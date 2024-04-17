// 当您的应用程序处理的计算量大到足以暂时阻止其他计算时，您就应该使用隔离。
// 最常见的示例是在Flutter应用程序中，当您需要执行大型计算时，否则可能会导致 UI 无响应
/**
 * 没有任何规则规定何时必须使用隔离，但在以下一些情况下它们可能会很有用：
解析和解码特别大的 JSON blob。
处理和压缩照片、音频和视频。
转换音频和视频文件。
在大型列表或文件系统内执行复杂的搜索和过滤。
执行 I/O，例如与数据库通信。
处理大量网络请求。
 */

// 实现一个简单的工人隔离
/**
 * 这些示例实现了一个主隔离，它生成一个简单的工作隔离。 Isolate.run()简化了设置和管理工作隔离的步骤：
生成（启动并创建）一个隔离体。
在生成的隔离上运行函数。
捕获结果。
将结果返回到主隔离。
工作完成后终止隔离。
检查、捕获异常和错误并将其抛出回主隔离区。
 */

// 在新隔离中运行现有方法
// 在等待结果时，直接在主隔离中调用run()生成一个新隔离（后台工作者） ：main()
// const String filename = 'with_keys.json';
// void main() async {
//   final jsonData = await Isolate.run(_readAndParseJson);
//   print('Number of JSON keys: ${jsonData.length}');
// }

// 将您希望其执行的函数作为其第一个参数传递给工作程序隔离。在此示例中，它是现有函数_readAndParseJson()
// Future<Map<String, dynamic>> _readAndParseJson() async {
//   final fileData = await File(filename).readAsString();
//   final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
//   return jsonData;
// }
// Isolate.run()获取结果_readAndParseJson()返回并将值发送回主隔离，关闭工作隔离。
// 工作隔离将保存结果的内存传输到主隔离。它不复制数据。工作隔离执行验证过程以确保允许传输对象

// 发送带有隔离物的闭包
// 还可以run()直接在主隔离中使用函数文字或闭包创建一个简单的工作隔离
// const String filename = 'with_keys.json';
// void main() async {
//   final jsonData = await Isolate.run(() async {
//     final fileData = await File(filename).readAsString();
//     final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
//     return jsonData;
//   });
//   print('Number of JSON keys: ${jsonData.length}');
// }

// 使用端口在隔离之间发送多条消息
// ReceivePort和SendPort
/**
 * 一个SendPort对象只与一个对象相关联ReceivePort，但一个ReceivePort对象可以与多个SendPorts对象相关联。
 * 当您创建一个ReceivePort 时，它会为自己创建一个SendPort。您可以创建SendPorts可以将消息发送到现有ReceivePort
 */

// 设置端口
// 基本端口示例
// 步骤1：定义工人阶级
// 第 2 步：产生工人隔离体
// 第 3 步：在工作隔离上执行代码
// 步骤 4：处理主隔离上的消息
// 第 5 步：添加完成程序以确保您的隔离已设置

// 强大的端口
// 步骤1：定义工人阶级
// 步骤2：在Worker.spawn方法中创建
// 第 3 步：生成一个工人隔离Isolate.spawn
// 第 4 步：完成隔离设置过程
// 步骤5：同时处理多条消息
// 第 6 步：添加关闭端口的功能
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

class Worker {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  Future<Object?> parseJson(String message) async {
    if (_closed) throw StateError('Closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, message));
    return await completer.future;
  }

  static Future<Worker> spawn() async {
    // Create a receive port and add its initial message handler
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    // Spawn the isolate.
    try {
      await Isolate.spawn(_startRemoteIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return Worker._(receivePort, sendPort);
  }

  Worker._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  static void _handleCommandsToIsolate(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((message) {
      if (message == 'shutdown') {
        receivePort.close();
        return;
      }
      final (int id, String jsonText) = message as (int, String);
      try {
        final jsonData = jsonDecode(jsonText);
        sendPort.send((id, jsonData));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  static void _startRemoteIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}

class Worker1 {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  Future<Object?> parseJson(String message) async {
    if (_closed) throw StateError('Closed');
    final completer = Completer<Object?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, message));
    return await completer.future;
  }

  static Future<Worker> spawn() async {
    // Create a receive port and add its initial message handler
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    // Spawn the isolate.
    try {
      await Isolate.spawn(_startRemoteIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return Worker._(receivePort, sendPort);
  }

  Worker1._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  static void _handleCommandsToIsolate(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((message) {
      if (message == 'shutdown') {
        receivePort.close();
        return;
      }
      final (int id, String jsonText) = message as (int, String);
      try {
        final jsonData = jsonDecode(jsonText);
        sendPort.send((id, jsonData));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  static void _startRemoteIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}

void main(List<String> args) {
  void main() async {
    final worker = await Worker.spawn();
    print(await worker.parseJson('{"key":"value"}'));
    print(await worker.parseJson('"banana"'));
    print(await worker.parseJson('[true, false, null, 1, "string"]'));
    print(await Future.wait(
        [worker.parseJson('"yes"'), worker.parseJson('"no"')]));
    worker.close();
  }

  void main1() async {
    final worker = await Worker.spawn();
    print(await worker.parseJson('{"key":"value"}'));
    print(await worker.parseJson('"banana"'));
    print(await worker.parseJson('[true, false, null, 1, "string"]'));
    print(await Future.wait(
        [worker.parseJson('"yes"'), worker.parseJson('"no"')]));
    worker.close();
  }
}

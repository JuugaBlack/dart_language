import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

void main(List<String> args) async {
  // 事件循环
// Dart 的运行时模型基于事件循环。事件循环负责执行程序的代码、收集和处理事件等等
// while (eventQueue.waitForEvent()) {
//   eventQueue.processNextEvent();
}

// 异步
// http.get('https://example.com').then((response) {
//   if (response.statusCode == 200) {
//     print('Success!')'
//   }
// }
// }

// Future
Future<String> _readFileAsync(String filename) {
  final file = File(filename);

  // .readAsString() returns a Future.
  // .then() registers a callback to be executed when `readAsString` resolves.
  return file.readAsString().then((contents) {
    return contents.trim();
  });
}

// async-await语法
const String filename = 'with_keys.json';
void main1() {
  // Read some data.
  final fileData = _readFileSync();
  final jsonData = jsonDecode(fileData);

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}

String _readFileSync() {
  final file = File(filename);
  final contents = file.readAsStringSync();
  return contents.trim();
}

const String filename1 = 'with_keys.json';

void main2() async {
  // Read some data.
  // final fileData = await _readFileAsync();
  // final jsonData = jsonDecode(fileData);

  // Use that data.
  // print('Number of JSON keys: ${jsonData.length}');
}

Future<String> _readFileAsync1() async {
  final file = File(filename);
  final contents = await file.readAsString();
  return contents.trim();
}
// 该await关键字仅适用于async函数体之前的函数

// Stream
// 流在未来提供价值，并且随着时间的推移不断重复。随着时间的推移提供一系列int值的承诺具有类型Stream<int>
Stream<int> stream = Stream.periodic(const Duration(seconds: 1), (i) => i * i);
// await-for and yield
// Await-for 是一种 for 循环，它在提供新值时执行循环的每个后续迭代。换句话说，它用于“循环”流
Stream<int> sumStream(Stream<int> stream) async* {
  var sum = 0;
  await for (final value in stream) {
    yield sum += value;
  }
}

// Isolates
// 除了异步 API之外，Dart 还通过隔离支持并发
// 所有 Dart 代码都在隔离区内运行，而不是线程。使用隔离，您的 Dart 代码可以同时执行多个独立任务。隔离就像线程或进程，但每个隔离都有自己的内存和运行事件循环的单个线程。
/**
 * 每个隔离区都有自己的全局字段，确保隔离区中的任何状态都无法从任何其他隔离区访问。
 * 隔离体只能通过消息传递来相互通信。隔离之间没有共享状态意味着 Dart 中不会发生并发复杂性，例如互斥锁或锁 以及数据竞争。
 * 也就是说，隔离并不能完全防止竞争条件
*/

// Isolates
/**
 * 在 Dart 中，有两种处理隔离的方法，具体取决于用例：

用于Isolate.run()在单独的线程上执行单个计算。
用于Isolate.spawn()创建将随着时间的推移处理多条消息的隔离或后台工作人员。有关使用长寿命分离株的更多信息，请阅读分离株页面。
在大多数情况下，Isolate.run推荐使用 API 在后台运行进程
*/
int slowFib(int n) => n <= 1 ? 1 : slowFib(n - 1) + slowFib(n - 2);

// Compute without blocking current isolate.
void fib40() async {
  var result = await Isolate.run(() => slowFib(40));
  print('Fib(40) = $result');
}

/** 消息类型
 * 通过发送的消息SendPort 几乎可以是任何类型的 Dart 对象，但也有一些例外：
具有本机资源的对象，例如Socket.
ReceivePort
DynamicLibrary
Finalizable
Finalizer
NativeFinalizer
Pointer
UserTag
标记为的类的实例@pragma('vm:isolate-unsendable')
除了这些例外之外，可以发送任何对象
*/

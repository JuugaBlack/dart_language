// 处理Futures
/**
 * 当您需要完整 Future 的结果时，您有两种选择：
使用asyncand await，如此处和 异步编程 Codelab中所述。
使用 Future API，如 dart:async文档中所述。
async使用and的代码await是异步的，但它看起来很像同步代码
 */
Future<void> checkVersion() async {
  var version = await lookUpVersion();
  // Do something with version
}
/**
 * 尽管async函数可能执行耗时的操作，但它不会等待这些操作。
 * 相反，该async函数仅执行到遇到第一个await表达式为止。
 * 然后它返回一个Future对象，仅在await表达式完成后恢复执行
 */

// 使用try、catch和finally来处理使用以下代码的错误和清理await
try {
  version = await lookUpVersion();
} catch (e) {
  // React to inability to look up the version
}
// 可以await在一个函数中多次使用async
var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);

// 如果在使用 时出现编译时错误await，请确保await位于async函数中
void main() async {
  checkVersion();
  print('In main: version is ${await lookUpVersion()}');
}

// 声明异步函数
// 将关键字async添加到函数中会使其返回 Future
Future<String> lookUpVersion() async => '1.0.0';

// 处理流
// 在使用之前await for，请确保它使代码更清晰，并且您确实想要等待所有流的结果。
// 例如，您通常不应该使用await forUI 事件侦听器，因为 UI 框架会发送无穷无尽的事件流。
// 异步 for 循环
await for (varOrType identifier in expression) {
}
/**
 * expression的值必须具有 Stream 类型。执行过程如下：
等待流发出一个值。
执行 for 循环的主体，并将变量设置为发出的值。
重复 1 和 2，直到流关闭。
 */
// 要停止监听流，您可以使用breakorreturn语句，该语句会跳出 for 循环并取消订阅流
// 如果在实现异步 for 循环时遇到编译时错误，请确保它await for位于async函数中
void main1() async {
  await for (final request in requestServer) {
    handleRequest(request);
  }
}
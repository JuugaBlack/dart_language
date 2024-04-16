// 函数
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
// 箭头函数
// 箭头 (=>) 和分号 (;) 之间只能出现表达式，而不是语句

// 参数
/// 设置 [bold] 和 [hidden] 标志 ...
void enableFlags({bool? bold, bool? hidden}) {...}
enableFlags(bold: true, hidden: false);
/// 设置 [bold] 和 [hidden] 标志 ...
void enableFlags({bool bold = false, bool hidden = false}) {...}
// bold will be true; hidden will be false.
enableFlags(bold: true);
// 如果您希望命名参数是强制性的，要求调用者提供参数的值，请使用以下注释required
const Scrollbar({super.key, required Widget child});
// 标记为 的参数required仍然可以为空
const Scrollbar({super.key, required Widget? child});
repeat(times: 2, () {
  ...
});

// 可选位置参数
String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
// 不带可选参数调用此函数的示例
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
// 使用第三个参数调用此函数的示例
assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');

// 要为除 null 之外的可选位置参数定义默认值，请使用 = 指定默认值。
// 指定的值必须是编译时常量
String say(String from, String msg, [String device = 'carrier pigeon']) {
  var result = '$from says $msg with a $device';
  return result;
}
assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');

// main() 函数
void main() {
  print('Hello, World!');
}
// main()以下是接受参数的命令行应用程序的函数示例
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}

// 作为一流对象的函数
void printElement(int element) {
  print(element);
}
var list = [1, 2, 3];
// 将 printElement 作为参数传递
list.forEach(printElement);
// 将函数分配给变量
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');

// 匿名函数
const list = ['apples', 'bananas', 'oranges'];
list.map((item) {
  return item.toUpperCase();
}).forEach((item) {
  print('$item: ${item.length}');
});

// 词汇作用域
bool topLevel = true;
void main() {
  var insideMain = true;
  void myFunction() {
    var insideFunction = true;
    void nestedFunction() {
      var insideNestedFunction = true;
      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}

// 词汇闭包
// 返回一个将 [addBy] 添加到函数参数的函数
Function makeAdder(int addBy) {
  return (int i) => addBy + i;
}
void main() {
  // Create a function that adds 2.
  var add2 = makeAdder(2);
  // Create a function that adds 4.
  var add4 = makeAdder(4);
  assert(add2(3) == 5);
  assert(add4(3) == 7);
}

// 函数的相等性
void foo() {} // 顶级函数
class A {
  static void bar() {} // 静态方法
  void baz() {} // 实例方法
}
void main() {
  Function x;
  // Comparing top-level functions.
  x = foo;
  assert(foo == x);
  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);
  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;
  // 这些闭包引用同一个实例 (#2),
  // so they're equal.
  assert(y.baz == x);
  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}

// 返回值
foo() {}
assert(foo() == null);
(String, int) foo() {
  return ('something', 42);
}

// 生成器
// 同步生成器：返回一个Iterable对象。异步生成器：返回一个Stream对象。
// 要实现同步生成器函数，请将函数体标记为sync*，并使用yield语句传递值
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
// 要实现异步生成器函数，请将函数体标记为async*，并使用yield语句传递值
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
// 如果您的生成器是递归的，您可以通过使用以下方法来提高其性能yield*
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}

// 外部函数
external void someFunc(int i);
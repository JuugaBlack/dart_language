// 分支机构
/*
if陈述和要素
if-case陈述和要素
switch陈述和表达
您还可以使用以下方法操纵 Dart 中的控制流：
循环，如for和while
例外情况，例如try、catch、 和throw
*/

// if
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
// if-case
// 如果模式与值匹配，则分支将使用模式在范围内定义的任何变量执行
if (pair case [int x, int y]) return Point(x, y);
if (pair case [int x, int y]) {
  print('Was coordinate array $x,$y');
} else {
  throw FormatException('Invalid coordinates.');
}

// switch
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClosed();
  case 'PENDING':
    executePending();
  case 'APPROVED':
    executeApproved();
  case 'DENIED':
    executeDenied();
  case 'OPEN':
    executeOpen();
  default:
    executeUnknown();
}
switch (command) {
  case 'OPEN':
    executeOpen();
    continue newCase; // Continues executing at the newCase label.

  case 'DENIED': // Empty case falls through.
  case 'CLOSED':
    executeClosed(); // Runs for both DENIED and CLOSED,

  newCase:
  case 'PENDING':
    executeNowClosed(); // Runs for both OPEN and PENDING.
}

// switch表达式
// 表达式根据大小写匹配的表达式主体生成一个值switch 。
//您可以在 Dart 允许表达式的任何地方使用 switch 表达式，但表达式语句的开头除外
var x = switch (y) { ... };
print(switch (x) { ... });
return switch (x) { ... };
switch (charCode) {
  case slash || star || plus || minus: // Logical-or pattern
    token = operator(charCode);
  case comma || semicolon: // Logical-or pattern
    token = punctuation(charCode);
  case >= digit0 && <= digit9: // Relational and logical-and patterns
    token = number();
  default:
    throw FormatException('Invalid');
}
token = switch (charCode) {
  slash || star || plus || minus => operator(charCode),
  comma || semicolon => punctuation(charCode),
  >= digit0 && <= digit9 => number(),
  _ => throw FormatException('Invalid')
};

// 详尽性检查
// 详尽性检查是一项功能，如果某个值可能进入开关但与任何情况都不匹配，则会报告编译时错误
switch (nullableBool) {
  case true:
    print('yes');
  case false:
    print('no');
}
// 枚举和密封类型对于开关特别有用，因为即使没有默认情况，它们的可能值也是已知的并且完全可枚举。
// 在类上使用sealed修饰符可以在切换该类的子类型时启用详尽检查
sealed class Shape {}
class Square implements Shape {
  final double length;
  Square(this.length);
}
class Circle implements Shape {
  final double radius;
  Circle(this.radius);
}
double calculateArea(Shape shape) => switch (shape) {
      Square(length: var l) => l * l,
      Circle(radius: var r) => math.pi * r * r
    };

// 保护条款
// 要在子句后设置可选的保护子句case，请使用关键字when。
// 保护子句可以跟在if case, 以及switch语句和表达式之后
// Switch statement:
switch (something) {
  case somePattern when some || boolean || expression:
    //             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
    body;
}
// Switch expression:
var value = switch (something) {
  somePattern when some || boolean || expression => body,
  //               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
}
// If-case statement:
if (something case somePattern when some || boolean || expression) {
  //                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guard clause.
  body;
}
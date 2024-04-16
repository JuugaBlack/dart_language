// 使用类成员
/**
 * 对象具有由函数和数据（分别为方法和 实例变量）组成的成员。
 * 当您调用方法时，您是 在对象上调用它：该方法可以访问该对象的函数和数据。
 * 使用点 ( .) 来引用实例变量或方法
 */
var p = Point(2, 2);
// Get the value of y.
assert(p.y == 2);
// Invoke distanceTo() on p.
double distance = p.distanceTo(Point(4, 4));
// 当最左边的操作数为空时，使用?.代替来.避免异常
var a = p?.y;

// 构造函数
// 可以使用构造函数创建对象。构造函数名称可以是ClassName或ClassName.identifier
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
// new 关键字可选用
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
// 有些类提供常量构造函数。要使用常量构造函数创建编译时常量
var p = const ImmutablePoint(2, 2);
// 构造两个相同的编译时常量会产生一个规范实例
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);
assert(identical(a, b)); // They are the same instance!
// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
// 可以省略除第一次使用const关键字之外的所有内容
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
// 如果常量构造函数位于常量上下文之外并且在没有 的情况下调用const，它将创建一个非常量对象
var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant
assert(!identical(a, b)); // NOT the same instance!

// 获取对象的类型
print('The type of a is ${a.runtimeType}');

// 实例变量
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.
}
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
}
void main() {
  var point = Point();
  point.x = 4; // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
double initialX = 1.5;
class Point {
  // OK, can access declarations that do not depend on `this`:
  double? x = initialX;
  // ERROR, can't access `this` in non-`late` initializer:
  double? y = this.x;
  // OK, can access `this` in `late` initializer:
  late double? z = this.x;
  // OK, `this.fieldName` is a parameter declaration, not an expression:
  Point(this.x, this.y);
}
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();
  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}

// 隐式接口
// 如果要创建一个支持类 B 的 API 的类 A，但不继承 B 的实现，则类 A 应该实现 B 接口
// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  final String _name;
  // Not in the interface, since this is a constructor.
  Person(this._name);
  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}
// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';
  String greet(String who) => 'Hi $who. Do you know who I am?';
}
String greetBob(Person person) => person.greet('Bob');
void main() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}
// 指定一个类实现多个接口的示例
class Point implements Comparable, Location {...}

// 类变量和方法
// 静态变量
class Queue {
  static const initialCapacity = 16;
  // ···
}
void main() {
  assert(Queue.initialCapacity == 16);
}
// 静态方法
import 'dart:math';
class Point {
  double x, y;
  Point(this.x, this.y);
  static double distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}
void main() {
  var a = Point(2, 2);
  var b = Point(4, 4);
  var distance = Point.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}
// 对于常见或广泛使用的实用程序和功能，请考虑使用顶级函数而不是静态方法
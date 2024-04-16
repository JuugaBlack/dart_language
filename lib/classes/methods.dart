// 实例方法
import 'dart:math';

class Point {
  final double x;
  final double y;
  // 设置 x 和 y 实例变量
  // 在构造函数主体运行之前
  Point(this.x, this.y);
  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class Vector {
  final int x, y;
  Vector(this.x, this.y);
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);
  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;
  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);
  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}

// getter 和 setter
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 定义两个计算属性：右侧和底部。
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}

// 抽象方法
abstract class Doer {
  // 定义实例变量和方法
  void doSomething(); // 定义一个抽象方法
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // 提供一个实现，所以这里的方法不是抽象的
  }
}

// 构造函数
class Point {
  double x = 0;
  double y = 0;
  Point(this.x, this.y);
}
// 关键字this指的是当前实例.this仅当存在名称冲突时使用。否则，Dart 风格会忽略this.

// 初始化形式参数
class Point {
  final double x;
  final double y;
  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);
}
// 如果您需要执行一些无法在初始化列表中表达的逻辑，请使用该逻辑创建一个工厂构造函数 （或静态方法），
// 然后将计算值传递给普通构造函数

// 默认构造函数
// 如果您不声明构造函数，则会为您提供默认构造函数。默认构造函数没有参数，并调用超类中的无参数构造函数
// 构造函数不会被继承 子类不会从其超类继承构造函数。
// 未声明构造函数的子类仅具有默认（无参数、无名称）构造函数

// 命名构造函数
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
  // Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}

// 调用非默认超类构造函数
/**执行顺序如下：
 *初始化列表
 *超类的无参数构造函数
 *主类的无参数构造函数 
*/
class Person {
  String? firstName;
  Person.fromJson(Map data) {
    print('in Person');
  }
}
class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}
void main() {
  var employee = Employee.fromJson({});
  print(employee);
  // Prints:
  // in Person
  // in Employee
  // Instance of 'Employee'
}
class Employee extends Person {
  Employee() : super.fromJson(fetchDefaultData());
  // ···
}

// 超参数
class Vector2d {
  final double x;
  final double y;
  Vector2d(this.x, this.y);
}
class Vector3d extends Vector2d {
  final double z;
  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
class Vector2d {
  // ...
  Vector2d.named({required this.x, required this.y});
}
class Vector3d extends Vector2d {
  // ...
  // Forward the y parameter to the named super constructor like:
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}

// 初始化列表
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
      y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
// 初始化程序的右侧无权访问this
Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}

// 重定向构造函数
class Point {
  double x, y;
  // The main constructor for this class.
  Point(this.x, this.y);
  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}

// 常量构造函数
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);
  final double x, y;
  const ImmutablePoint(this.x, this.y);
}

// 工厂构造函数
// 在实现并不总是创建其类的新实例的构造函数时，请使用关键字factory
class Logger {
  final String name;
  bool mute = false;
  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};
  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }
  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }
  Logger._internal(this.name);
  void log(String msg) {
    if (!mute) print(msg);
  }
}
// 工厂构造函数无权访问this
var logger = Logger('UI');
logger.log('Button clicked');
var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
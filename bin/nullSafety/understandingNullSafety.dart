class SomeClass {
  static int staticField = 0;
}

class SomeClass1 {
  int atDeclaration = 0;
  int initializingFormal;
  int initializationList;

  SomeClass1(this.initializingFormal) : initializationList = 0;
}

// 使用空安全:
class Point {
  late final double x, y;

  // bool operator ==(Object other) {
  // if (other is! Point) wrongType('Point', other);
  // return x == other.x && y == other.y;
  // }
}

class Thing {
  get doohickey => null;
}

// 错误地使用空安全:
class HttpResponse {
  final int code;
  final String? error;

  HttpResponse.ok()
      : code = 200,
        error = null;
  HttpResponse.notFound()
      : code = 404,
        error = 'Not found';

  @override
  String toString() {
    if (code == 200) return 'OK';
    // return 'ERROR $code ${error.toUpperCase()}';
    return '';
  }
}

// 错误地使用空安全:
class Coffee {
  late String _temperature;

  void heat() {
    _temperature = 'hot';
  }

  void chill() {
    _temperature = 'iced';
  }

  String serve() => _temperature + ' coffee';
}

// 使用空安全:
class Coffee1 {
  String? _temperature;

  void heat() {
    _temperature = 'hot';
  }

  void chill() {
    _temperature = 'iced';
  }

  String serve() => _temperature! + ' coffee';
}

// 使用空安全:
class Coffee2 {
  late String _temperature;

  void heat() {
    _temperature = 'hot';
  }

  void chill() {
    _temperature = 'iced';
  }

  String serve() => _temperature + ' coffee';
}

// 延迟初始化
// 使用空安全:
class Weather {
  // late int _temperature = _readThermometer();
}

// 延迟的终值
// 使用空安全:
class Coffee3 {
  late final String _temperature;

  void heat() {
    _temperature = 'hot';
  }

  void chill() {
    _temperature = 'iced';
  }

  String serve() => _temperature + ' coffee';
}

// 抽象字段
abstract class Cup {
  // Beverage contents;
}

abstract class Cup2 {
  // Beverage get contents;
  // set contents(Beverage);
}

abstract class Cup3 {
  // abstract Beverage contents;
}

// 与可空字段共舞
// 错误地使用空安全:
class Coffee4 {
  String? _temperature;

  void heat() {
    _temperature = 'hot';
  }

  void chill() {
    _temperature = 'iced';
  }

  void checkTemp() {
    if (_temperature != null) {
      // print('Ready to serve ' + _temperature + '!');
    }
  }

  String serve() => _temperature! + ' coffee';
}

// 可空性和泛型
// 使用空安全:
class Box<T> {
  final T object;
  Box(this.object);
}

// 使用空安全:
class Box1<T> {
  T? object;
  Box1.empty();
  Box1.full(this.object);
}

// 使用空安全:
class Box2<T> {
  T? object;
  Box2.empty();
  Box2.full(this.object);
  T unbox() => object as T;
}

// 使用空安全:
class Interval<T extends num> {
  T min, max;
  Interval(this.min, this.max);
  bool get isEmpty => max <= min;
}

// 使用空安全:
class Interval1<T extends num?> {
  late T min, max;

  // Interval(this.min, this.max);

  bool get isEmpty {
    var localMin = min;
    var localMax = max;

    // 没有最小值或最大值意味着开放式区间
    if (localMin == null || localMax == null) return false;
    return localMax <= localMin;
  }
}

void main(List<String> args) {
  // Without null safety:
  bool isEmpty(String string) => string.length == 0;
  // isEmpty(null);
  // 对于空安全而言，我们的目标是让你对代码中的 null 可见且可控，并且确保它不会传递至某些位置从而引发崩溃

  // 类型系统中的可空性
  // 非空和可空类型
  // 除了特殊的 Null 类型允许传递 null 值，其他类型均不允许。我们已经将所有的类型设置为 默认不可空 的类型
  // Using null safety:
  makeCoffee(String coffee, [String? dairy]) {
    if (dairy != null) {
      print('$coffee with $dairy');
    } else {
      print('Black $coffee');
    }
  }

// 使用可空类型
// Hypothetical unsound null safety:
  bad(String? maybeString) {
    // print(maybeString.length);
  }
  bad(null);

  // Hypothetical unsound null safety:
  requireStringNotNull(String definitelyString) {
    print(definitelyString.length);
  }

  String? maybeString = null; // Or not!
  requireStringNotNull(maybeString!);

// 没有空安全:
  requireStringNotObject(String definitelyString) {
    print(definitelyString.length);
  }

// 隐式转换 在 Dart 中一直存在。假设你将类型为 Object 的实例传递给了需要 String 的函数，类型检查器会允许你这样做
  Object maybeString1 = 'it is';
  requireStringNotObject(maybeString);

// 为了保持健全性，编译器为 requireStringNotObject() 的参数静默添加了 as String 强制转换。在运行时进行转换可能会抛出异常，但在编译时，Dart 允许这样的操作
// 这会让 requireStringNotNull() 的调用产生你预料中的编译错误。同时也意味着，类似 requireStringNotObject() 这样的 所有 隐式转换调用都变成了编译错误。你需要自己添加显式类型转换
// 使用空安全:
  requireStringNotObject1(String definitelyString) {
    print(definitelyString.length);
  }

  Object maybeString2 = 'it is';
  requireStringNotObject(maybeString2 as String);

// 没有空安全:
// List<int> filterEvens(List<int> ints) {
  // return ints.where((n) => n.isEven);
// }
// .where() 方法是懒加载的，所以它返回了一个 Iterable 而非 List。这段代码会正常编译，但会在运行时抛出一个异常，提示你在对 Iterable 进行转换为 filterEvens 声明的返回类型 List 时遇到了错误。在隐式转换移除后，这就变成了一个编译错误

// 顶层及底层
// 如果这张有向图的顶部有是一个单一的超类（直接或间接），那么这个类型称为 顶层类型。类似的，如果有一个在底部有一个奇怪的类型，是所有类型的子类，这个类型就被称为 底层类型

// 确保正确性
// 无效的返回值
// 没有空安全:
// String missingReturn() {
//   // No return.
// }

// 使用空安全:
  String alwaysReturns(int n) {
    if (n == 0) {
      return 'zero';
    } else if (n < 0) {
      throw ArgumentError('Negative values not allowed.');
    } else {
      if (n > 1000) {
        return 'big';
      } else {
        return n.toString();
      }
    }
  }

// 未初始化的变量
/**
 * 当你在声明变量时，如果没有传递一个显式的初始化内容，Dart 默认会将变量初始化为 null。这的确非常方便，但在变量可空的情况下，明显非常不安全。所以，我们需要加强对非空变量的处理：
 * 顶层变量和静态字段必须包含一个初始化方法
 * 实例的字段也必须在声明时包含初始化方法，可以为常见初始化形式，也可以在实例的构造方法中进行初始化
 * 局部变量的灵活度最高。一个非空的变量 不一定需要 一个初始化方法
 * 可选参数必须具有默认值
 */
  int topLevel = 0;
// Using null safety:
  int tracingFibonacci(int n) {
    int result;
    if (n < 2) {
      result = n;
    } else {
      result = tracingFibonacci(n - 2) + tracingFibonacci(n - 1);
    }

    print(result);
    return result;
  }

// 流程分析
// 有或无空安全:
  bool isEmptyList(Object object) {
    if (object is List) {
      return object.isEmpty; // <-- OK!
    } else {
      return false;
    }
  }

// 没有空安全:
  bool isEmptyList1(Object object) {
    if (object is! List) return false;
    return object.isEmpty; // <-- Error!
  }

// 可达性分析
// 使用空安全:
  bool isEmptyList2(Object object) {
    if (object is! List) return false;
    return object.isEmpty;
  }

// 为不可达的代码准备的 Never
// Using null safety:
  Never wrongType(String type, Object value) {
    throw ArgumentError('Expected $type, but was ${value.runtimeType}.');
  }

// 绝对的赋值分析
// 使用空安全:
  int tracingFibonacci1(int n) {
    final int result;
    if (n < 2) {
      result = n;
    } else {
      result = tracingFibonacci(n - 2) + tracingFibonacci(n - 1);
    }

    print(result);
    return result;
  }

// 空检查的类型提升
// 使用空安全:
  String makeCommand(String executable, [List<String>? arguments]) {
    var result = executable;
    if (arguments != null) {
      result += ' ' + arguments.join(' ');
    }
    return result;
  }

// 使用空安全:
  String makeCommand1(String executable, [List<String>? arguments]) {
    var result = executable;
    if (arguments == null) return result;
    return result + ' ' + arguments.join(' ');
  }

// 无用代码的警告
// 使用空安全:
  String checkList(List<Object> list) {
    if (list?.isEmpty ?? false) {
      return 'Got nothing';
    }
    return 'Got something';
  }

// 使用空安全:
  String checkList1(List<Object>? list) {
    if (list == null) return 'No list';
    if (list?.isEmpty ?? false) {
      return 'Empty list';
    }
    return 'Got something';
  }

// 与可空类型共舞
// 更智能的空判断方法
// 没有空安全:
// String notAString = null;
// print(notAString?.length);
// 使用空安全:
  String? notAString = null;
  print(notAString?.length);
// 使用空安全:
  String? notAString1 = null;
  print(notAString1?.length.isEven);
  String? notAString2 = null;
  print(notAString2?.length?.isEven);
// 使用空安全:
  showGizmo(Thing? thing) {
    print(thing?.doohickey?.gizmo);
  }

// 使用空安全:
  showGizmo1(Thing? thing) {
    print(thing?.doohickey.gizmo);
  }

// 使用空安全:
  showGizmo2(Thing? thing) {
    print(thing?.doohickey?.gizmo);
  }
// 使用空安全:
// 空感知级联:
// receiver?..method();
// 空感知索引运算符:
// receiver?[index];
// 允许有或没有空安全:
// function?.call(arg1, arg2);

// 空值断言操作符
// 使用空安全:
// String toString() {
//   if (code == 200) return 'OK';
//   return 'ERROR $code ${(error as String).toUpperCase()}';
// }

// 懒加载的变量
  var coffee = Coffee();
  coffee.heat();
  coffee.serve();

// 必需的命名参数
// 使用空安全:
  function({int? a, required int? b, int? c, required int? d}) {}

// 使用空安全:
  void checkTemp() {
    // var temperature = _temperature;
    // if (temperature != null) {
    // print('Ready to serve ' + temperature + '!');
    // }
  }
  main1() {
    Box<String>('a string');
    Box<int?>(null);
  }

// 使用空安全:
// main2() {
//   var box = Box<int?>.full(null);
//   print(box.unbox());
// }

// 核心库的改动
// Map 的索引操作符是可空的
// 错误地使用空安全:
  var map = {'key': 'value'};
// print(map['key'].length); // Error.
// 使用空安全:
  var map1 = {'key': 'value'};
  print(map1['key']!.length); // OK.

// 去除 List 的非命名构造
// 不能对非空的列表设置更大的长度
// 在迭代前后不能访问 Iterator.current
}

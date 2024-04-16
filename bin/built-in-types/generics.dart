/**
 * 为什么要使用泛型？
 类型安全通常需要泛型，但它们比仅仅允许代码运行有更多好处：
 正确指定泛型类型可以生成更好的代码。
 您可以使用泛型来减少代码重复。
 */
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}

abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}

abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

void main(List<String> args) {
  // 使用集合文字
// 列表、集合和映射文字可以参数化
  var names = <String>['Seth', 'Kathy', 'Lars'];
  var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
  var pages = <String, String>{
    'index.html': 'Homepage',
    'robots.txt': 'Hints for web robots',
    'humans.txt': 'We are people, not machines'
  };

// 将参数化类型与构造函数一起使用
// 要在使用构造函数时指定一种或多种类型，请将类型放在<...>类名后面的尖括号 ( ) 中
  var nameSet = Set<String>.from(names);
// var views = Map<int, View>();
// 通用集合及其包含的类型
// Dart 泛型类型是具体化的，这意味着它们在运行时携带其类型信息
  var names1 = <String>[];
  names.addAll(['Seth', 'Kathy', 'Lars']);
  print(names1 is List<String>); // true

// 限制参数化类型
// 实现泛型类型时，您可能希望限制可以作为参数提供的类型，以便参数必须是特定类型的子类型。您可以使用 extends 来执行此操作

// 可以使用SomeBaseClass或其任何子类型作为通用参数
  var someBaseClassFoo = Foo<Object>();
  var extenderFoo = Foo<Object>();
  var foo = Foo();
  print(foo); // Instance of 'Foo<SomeBaseClass>'

// 使用通用方法
  T first<T>(List<T> ts) {
    // 做一些初步工作或错误检查，然后......
    T tmp = ts[0];
    // 进行一些额外的检查或处理...
    return tmp;
  }
}

class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}

// 除了 extends 之外，您还可以与其他类型一起使用Object
class Foo1<T extends Object> {
  String toString() => "Instance of 'Foo<$T>'";
}

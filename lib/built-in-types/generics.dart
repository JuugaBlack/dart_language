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

// 使用集合文字
// 列表、集合和映射文字可以参数化
Map<String, dynamic> generateCollections() {
  var names = <String>['Seth', 'Kathy', 'Lars'];
  var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
  var nameSet = Set<String>.from(names);

  var collections = {
    'names': names,
    'uniqueNames': uniqueNames,
    'nameSet': nameSet,
    'isListString': names is List<String>
  };

  return collections;
}

// 限制参数化类型
// 实现泛型类型时，您可能希望限制可以作为参数提供的类型，以便参数必须是特定类型的子类型。您可以使用 extends 来执行此操作
class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}
// 除了 extends 之外，您还可以与其他类型一起使用Object
// class Foo<T extends SomeBaseClass> {
//   String toString() => "Instance of 'Foo<$T>'";
// }
// class Extender extends SomeBaseClass {...}
// // 可以使用SomeBaseClass或其任何子类型作为通用参数
// var someBaseClassFoo = Foo<SomeBaseClass>();
// var extenderFoo = Foo<Extender>();
// var foo = Foo();
// print(foo); // Instance of 'Foo<SomeBaseClass>'

// 使用通用方法
T first<T>(List<T> ts) {
  // 做一些初步工作或错误检查，然后......
  T tmp = ts[0];
  // 进行一些额外的检查或处理...
  return tmp;
}

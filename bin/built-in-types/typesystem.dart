void printInts(List<int> a) => print(a);

void main() {
  final list = <int>[];
  list.add(1);
  list.add(2);
  printInts(list);
}
class Animal {
  void chase(Animal a) { ... }
  Animal get parent => ...
}
class HoneyBadger extends Animal {
  @override
  void chase(Animal a) { ... }

  @override
  HoneyBadger get parent => ...
}
// 如果有合理的理由使用子类型，可以使用 covariant 关键字
class Animal {
  void chase(Animal a) { ... }
  Animal get parent => ...
}
class HoneyBadger extends Animal {
  @override
  void chase(Object a) { ... }

  @override
  Animal get parent => ...
}
Animal a = Cat();
a.chase(Alligator()); // Not type safe or feline safe.
Map<String, dynamic> arguments = {'argA': 'hello', 'argB': 42};
var arguments = {'argA': 'hello', 'argB': 42}; // Map<String, Object>

// 局部变量推断
num y = 3; // A num can be double or int.
y = 4.0;

// 参数类型推断

// Inferred as if you wrote <int>[].
List<int> listOfInt = [];
// Inferred as if you wrote <double>[3.0].
var listOfDouble = [3.0];
// Inferred as Iterable<int>.
var ints = listOfDouble.map((x) => x.toInt());
Cat c = Cat();
Animal c = Cat();
Cat c = MaineCoon();
List<MaineCoon> myMaineCoons = ...
List<Cat> myCats = myMaineCoons;
List<Animal> myAnimals = ...
List<Cat> myCats = myAnimals as List<Cat>;
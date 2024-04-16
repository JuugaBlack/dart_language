// 枚举类型
// 所有枚举都会自动扩展Enum类。它们也是密封的，这意味着它们不能被子类化、实现、混入或以其他方式显式实例化
// 抽象类和 mixin 可以显式实现或扩展Enum，但除非它们随后由枚举声明实现或混合到枚举声明中，否则没有对象可以实际实现该类或 mixin 的类型

// 声明简单枚举
enum Color { red, green, blue }

// 声明增强枚举
// Dart 还允许枚举声明来声明具有字段、方法和 const 构造函数的类，这些构造函数仅限于固定数量的已知常量实例
/**要声明增强的枚举，请遵循与普通类类似的语法，但有一些额外的要求：
实例变量必须是final，包括由mixins添加的变量。
所有生成构造函数都必须是常量。
工厂构造函数只能返回固定的已知枚举实例之一。
没有其他类可以像Enum自动扩展那样扩展。
不能覆盖index,hashCode等号运算符==。
values不能在枚举中声明name 成员，因为它会与自动生成的静态valuesgetter 冲突。
枚举的所有实例都必须在声明的开头声明，并且必须至少声明一个实例。 
增强枚举中的实例方法可以用来this引用当前枚举值
*/
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);
  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });
  final int tires;
  final int passengers;
  final int carbonPerKilometer;
  int get carbonFootprint => (carbonPerKilometer / passengers).round();
  bool get isTwoWheeled => this == Vehicle.bicycle;
  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}

// 使用枚举
final favoriteColor = Color.blue;
if (favoriteColor == Color.blue) {
  print('Your favorite color is blue!');
}
// 枚举中的每个值都有一个indexgetter，它返回枚举声明中值从零开始的位置
assert(Color.red.index == 0);
assert(Color.green.index == 1);
assert(Color.blue.index == 2);
// 要获取所有枚举值的列表，请使用枚举values常量
List<Color> colors = Color.values;
assert(colors[2] == Color.blue);
// 可以在switch 语句中使用枚举，如果您不处理所有枚举的值，您将收到警告
var aColor = Color.blue;
switch (aColor) {
  case Color.red:
    print('Red as roses!');
  case Color.green:
    print('Green as grass!');
  default: // Without this, you see a WARNING.
    print(aColor); // 'Color.blue'
}
// 如果您需要访问枚举值的名称（例如'blue'from ）Color.blue，请使用以下.name属性
print(Color.blue.name);
// 可以像访问普通对象一样访问枚举值的成员
print(Vehicle.car.carbonFootprint);
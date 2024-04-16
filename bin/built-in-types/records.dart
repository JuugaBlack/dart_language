void main(List<String> args) {
  // 记录语法
// 记录表达式是以逗号分隔的命名或位置字段列表，括在括号中
  var record = ('first', a: 2, b: true, 'last');
  (int, int) swap((int, int) record) {
    var (a, b) = record;
    return (b, a);
  }

// 记录表达式和类型注释中的字段反映了参数和参数在函数中的工作方式
// 在变量声明中记录类型注释
// (String, int) record1;
// // 用记录表达式初始化它
// record2 = ('A string', 123);
// ({int a, bool b}) record3;
// record4 = (a: 123, b: true);
// ({int a, int b}) recordAB = (a: 1, b: 2);
// ({int x, int y}) recordXY = (x: 3, y: 4);
// // Compile error! These records don't have the same type.
// // recordAB = recordXY;
// (int a, int b) recordAB = (1, 2);
// (int x, int y) recordXY = (3, 4);
// recordAB = recordXY; // OK.

// 记录字段
// 记录字段可以通过内置的 getter 访问
  var record1 = ('first', a: 2, b: true, 'last');
  print(record1.$1); // Prints 'first'
  print(record1.a); // Prints 2
  print(record1.b); // Prints true
  print(record1.$2); // Prints 'last'

// 记录类型
  (num, Object) pair = (42, 'a');
  var first = pair.$1;
  var second = pair.$2;

// 记录相等
// 如果两条记录具有相同的形状（字段集），并且它们对应的字段具有相同的值，则它们相等
  (int x, int y, int z) point = (1, 2, 3);
  (int r, int g, int b) color = (1, 2, 3);
  print(point == color); // Prints 'true'.
  ({int x, int y, int z}) point1 = (x: 1, y: 2, z: 3);
  ({int r, int g, int b}) color1 = (r: 1, g: 2, b: 3);
  print(point1 == color1); // Prints 'false'. 在不相关的类型上等于

// 多重return
// Returns multiple values in a record:
  (String name, int age) userInfo(Map<String, dynamic> json) {
    return (json['name'] as String, json['age'] as int);
  }

  final json = <String, dynamic>{
    'name': 'Dash',
    'age': 10,
    'color': 'blue',
  };
// Destructures using a record pattern with positional fields:
  var (name, age) = userInfo(json);
/* Equivalent to:
  var info = userInfo(json);
  var name = info.$1;
  var age  = info.$2;
*/
// 还可以使用冒号语法使用其命名字段来解构记录
// ({String name, int age}) userInfo(Map<String, dynamic> json);
// ···
// Destructures using a record pattern with named fields:
// final (:name, :age) = userInfo(json);

// 记录的多返回和异构类型特征可以实现不同类型 future 的并行化
}

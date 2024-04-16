// 列表（数组）
void createListsAndSets() {
  // 创建列表
  var list1 = [1, 2, 3];
  var list2 = ['Car', 'Boat', 'Plane'];

  // 验证列表的长度和索引访问
  assert(list1.length == 3);
  assert(list1[1] == 2);
  list1[1] = 1;
  assert(list1[1] == 1);

  // 创建编译时常量列表
  var constantList = const [1, 2, 3];

  // 创建集合
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};

  // 创建空集合并添加元素
  var names = <String>{};
  names.add('John');
  names.addAll(['Alice', 'Bob']);

  // 验证集合的长度
  assert(names.length == 3);

  // 创建编译时常量集合
  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine',
  };

  print('Lists and sets created successfully!');
}
// constantSet.add('helium'); // This line will cause an error.

// map
// 映射是一个将键和值关联起来的对象。键和值都可以是任何类型的对象。
// 每个键仅出现一次，但您可以多次使用相同的值
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};
var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
// 可以使用 Map 构造函数创建相同的对象
// var gifts = Map<String, String>();
// gifts['first'] = 'partridge';
// gifts['second'] = 'turtledoves';
// gifts['fifth'] = 'golden rings';
// var nobleGases = Map<int, String>();
// nobleGases[2] = 'helium';
// nobleGases[10] = 'neon';
// nobleGases[18] = 'argon';
// // 使用下标赋值运算符 ( ) 将新的键值对添加到现有映射[]=
// var gifts = {'first': 'partridge'};
// gifts['fourth'] = 'calling birds'; // Add a key-value pair
// // 使用下标运算符 ( ) 从映射中检索值[]
// var gifts = {'first': 'partridge'};
// assert(gifts['first'] == 'partridge');
// // 如果你寻找地图上没有的key，你会得到null
// var gifts = {'first': 'partridge'};
// assert(gifts['fifth'] == null);
// 用于.length获取映射中键值对的数量
// var gifts = {'first': 'partridge'};
// gifts['fourth'] = 'calling birds';
// assert(gifts.length == 2);
final constantMap = const {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
// constantMap[2] = 'Helium'; // This line will cause an error.

// 展开运算符
List<String> generateNavigation(bool promoActive, String login) {
  // 控制流运算符
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  if (login == 'Manager') {
    nav.add('Inventory');
  }
  return nav;
}

List<String> generateStringList(List<int> listOfInts) {
  // 控制流运算符
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  return listOfStrings;
}

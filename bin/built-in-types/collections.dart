void main(List<String> args) {
  // 列表（数组，列表使用从零开始的索引
  var list = [1, 2, 3];
  assert(list.length == 3);
  assert(list[1] == 2);
  list[1] = 1;
  assert(list[1] == 1);
  var constantList = const [1, 2, 3]; // 编译时常量列表
  var list1 = [
    'Car',
    'Boat',
    'Plane',
  ];

// 集合，Dart 中的集合是独特项目的无序集合
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
// 要创建空集，请{}在前面添加类型参数，或分配{}给类型为 的变量Set
  var names = <String>{};
// Set<String> names = {}; // This works, too.
// var names = {}; // Creates a map, not a set.
  names.add('John');
  assert(names.contains('John')); // 检查集合中是否包含 'John'
// 使用add()或addAll()方法将项目添加到现有集合中
  var elements = <String>{};
  elements.add('fluorine');
  elements.addAll(halogens);
// 用于.length获取集合中的项目数
  assert(elements.length == 5);
// 要创建一个作为编译时常量的集合，请const在集合文字之前添加
  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine',
  };

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
  var gifts1 = Map<String, String>();
  gifts1['first'] = 'partridge';
  gifts1['second'] = 'turtledoves';
  gifts1['fifth'] = 'golden rings';
  var nobleGases1 = Map<int, String>();
  nobleGases1[2] = 'helium';
  nobleGases1[10] = 'neon';
  nobleGases1[18] = 'argon';
// 使用下标赋值运算符 ( ) 将新的键值对添加到现有映射[]=
  gifts['fourth'] = 'calling birds'; // Add a key-value pair
// 使用下标运算符 ( ) 从映射中检索值[]
  assert(gifts['first'] == 'partridge');
// 如果你寻找地图上没有的key，你会得到null
  assert(gifts['fifth'] == null);
// 用于.length获取映射中键值对的数量
  gifts['fourth'] = 'calling birds';
  assert(gifts.length == 2);
  final constantMap = const {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };

// 展开运算符
  var list2 = [0, ...list];
  assert(list2.length == 4);
  var list3 = [0, ...?list];
  assert(list3.length == 1);
// 控制流运算符
  var promoActive = true;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  var login = 'Manager';
  var nav2 = [
    'Home',
    'Furniture',
    'Plants',
    if (login == 'Manager') 'Inventory'
  ];
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
}

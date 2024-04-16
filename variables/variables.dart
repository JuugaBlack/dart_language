// 创建变量
var name = 'Bob';
Object name = 'Bob';
String name = 'Bob'; // 显式声明

// 空安全
String? name  // 可空类型。可以是“null”或字符串
String name   // 不可为 null 的类型。不能为“null”，但可以为字符串

// 默认值
int? lineCount;
assert(lineCount == null); // 如果条件为假，则断言将引发异常
int lineCount = 0; // 对于 null 安全性，必须在使用不可为 null 的变量之前初始化它们的值
int lineCount; // 不必在声明局部变量的地方对其进行初始化，但需要在使用它之前为其赋值
if (weLikeToCount) {
  lineCount = countLines();
} else {
  lineCount = 0;
}
print(lineCount);

// 后期变量
/// 声明一个不可为 null 的变量，该变量在声明后进行初始化。
/// 延迟初始化变量
// 如果未能初始化late变量，则在使用该变量时会出现运行时错误
late String description; // 如果您确定变量在使用之前已设置，但 Dart 不同意，您可以通过将变量标记为来修复错误
void main() {
  description = 'Feijoada!';
  print(description);
}
late String temperature = readThermometer(); 

// final和const
// 实例变量可以是final但不是const
final name = 'Bob'; 
final String nickname = 'Bobby';
name = 'Alice'; // 错误：最终变量只能设置一次
// 对要成为编译时常量的变量使用 const。如果 const 变量在类级别，则将其标记为 static const
const bar = 1000000; 
const double atm = 1.01325 * bar; 
// const 关键字不仅仅用于声明常量变量，还可以使用它来创建常量值，以及声明创建常量值的构造函数
var foo = const [];
final bar = const [];
const baz = []; 
foo = [1, 2, 3]; // 是 const []
baz = [42]; // 错误：无法为常量变量赋值
// 类型检查和强制转换(is和as)、扩展运算符(...和...?) 
const Object i = 3; 
const list = [i as int]; 
const map = {if (i is int) i: 'int'}; 
const set = {if (list is List<int>) ...list}; 
// 虽然final对象无法修改，但其字段可以更改。相比之下，const对象及其字段无法更改：它们是不可变的
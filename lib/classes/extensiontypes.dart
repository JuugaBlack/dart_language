// 扩展类型
extension type IdNumber(int id) {
  // Wraps the 'int' type's '<' operator:
  operator <(IdNumber other) => id < other.id;
  // 不声明 '+' 运算符，例如，
  // 因为加法对于 ID 号没有意义。
}
void main() {
  // Without the discipline of an extension type,
  // 'int' exposes ID numbers to unsafe operations:
  int myUnsafeId = 42424242;
  myUnsafeId = myUnsafeId + 10; // This works, but shouldn't be allowed for IDs.
  var safeId = IdNumber(42424242);
  safeId + 10; // Compile-time error: No '+' operator.
  myUnsafeId = safeId; // Compile-time error: Wrong type.
  myUnsafeId = safeId as int; // OK: Run-time cast to representation type.
  safeId < IdNumber(42424241); // OK: Uses wrapped '<' operator.
}
/**
 * 扩展类型与包装类具有相同的用途，但不需要创建额外的运行时对象，当您需要包装大量对象时，这可能会变得昂贵。由于扩展类型仅是静态的并且在运行时编译，因此它们本质上是零成本。
   扩展方法（也称为“扩展”）是类似于扩展类型的静态抽象。但是，扩展方法直接 向其基础类型的每个实例添加功能。扩展类型不同；扩展类型的接口仅适用于静态类型为该扩展类型的表达式。默认情况下，它们与其基础类型的接口不同。
 */

// 语法
// 宣言
// 使用声明和名称定义新的扩展类型extension type，后跟括号中的表示类型声明
extension type E(int i) {
  // Define set of operations.
}
extension type E<T>(List<T> elements) {
  // ...
}
// 构造函数
extension type E(int i) {
  E.n(this.i);
  E.m(int j, String foo) : i = j + foo.length;
}
void main() {
  E(4); // Implicit unnamed constructor.
  E.n(3); // Named constructor.
  E.m(5, "Hello!"); // Named constructor with additional parameters.
}

extension type const E._(int it) {
  E() : this._(42);
  E.otherName(this.it);
}
void main2() {
  E();
  const E._(2);
  E.otherName(3);
}

// 还可以完全隐藏构造函数，而不仅仅是定义一个新的构造函数，使用与类相同的私有构造函数语法_
extension type E._(int i) {
  E.fromString(String foo) : i = int.parse(foo);
}
// 还可以声明转发生成构造函数或工厂构造函数 （也可以转发到子扩展类型的构造函数）
// 成员
extension type NumberE(int value) {
  // Operator:
  NumberE operator +(NumberE other) => NumberE(value + other.value);
  // Getter:
  NumberE get myNum => this;
  // Method:
  bool isValid() => !value.isNegative;
}
// 接口
// 扩展类型只能实现：
// 其表示类型。这使得表示类型的所有成员对扩展类型隐式可用。
extension type NumberI(int i) implements int {
  // 'NumberI' can invoke all members of 'int',
  // plus anything else it declares here.
}
// 其表示类型的超类型。这使得超类型的成员可用，但不一定是表示类型的所有成员。
extension type Sequence<T>(List<T> _) implements Iterable<T> {
  // Better operations than List.
}
extension type Id(int _id) implements Object {
  // Makes the extension type non-nullable.
  static Id? tryParse(String source) => int.tryParse(source) as Id?;
}
// 在同一表示类型上有效的另一种扩展类型。这允许您跨多个扩展类型重用操作（类似于多重继承）
extension type const Opt<T>._(({T value})? _) {
  const factory Opt(T value) = Val<T>;
  const factory Opt.none() = Non<T>;
}
extension type const Val<T>._(({T value}) _) implements Opt<T> {
  const Val(T value) : this._((value: value));
  T get value => _.value;
}
extension type const Non<T>._(Null _) implements Opt<Never> {
  const Non() : this._(null);
}
// @redeclare
extension type MyString(String _) implements String {
  // Replaces 'String.operator[]'
  @redeclare
  int operator [](int index) => codeUnitAt(index);
}

// 用法
extension type NumberE(int value) {
  NumberE operator +(NumberE other) => NumberE(value + other.value);
  NumberE get next => NumberE(value + 1);
  bool isValid() => !value.isNegative;
}
void testE() {
  var num = NumberE(1);
}

/**扩展类型有两个同样有效但本质上不同的核心用例：
为现有类型提供扩展接口。
为现有类型提供不同的接口。
 */
// 在任何情况下，扩展类型的表示类型都不是其子类型，因此在需要扩展类型的情况下表示类型不能互换使用
// 1.为现有类型提供扩展接口
extension type NumberT(int value) implements int {
  // Doesn't explicitly declare any members of 'int'.
  NumberT get i => this;
}
void main() {
  // All OK: Transparency allows invoking `int` members on the extension type:
  var v1 = NumberT(1); // v1 type: NumberT
  int v2 = NumberT(2); // v2 type: int
  var v3 = v1.i - v1; // v3 type: int
  var v4 = v2 + v1; // v4 type: int
  var v5 = 2 + v1; // v5 type: int
  // Error: Extension type interface is not available to representation type
  v2.i;
}

// 2.为现有类型提供不同的接口
void testE() {
  var num1 = NumberE(1);
  int num2 = NumberE(2); // Error: Can't assign 'NumberE' to 'int'.
  num1.isValid(); // OK: Extension member invocation.
  num1.isNegative(); // Error: 'NumberE' does not define 'int' member 'isNegative'.
  var sum1 = num1 + num1; // OK: 'NumberE' defines '+'.
  var diff1 = num1 - num1; // Error: 'NumberE' does not define 'int' member '-'.
  var diff2 =
      num1.value - 2; // OK: Can access representation object with reference.
  var sum2 = num1 + 2; // Error: Can't assign 'int' to parameter type 'NumberE'.
  List<NumberE> numbers = [
    NumberE(1),
    num1.next, // OK: 'next' getter returns type 'NumberE'.
    1, // Error: Can't assign 'int' element to list type 'NumberE'.
  ];
}

// 类型注意事项
void main() {
  var n = NumberE(1);
  // Run-time type of 'n' is representation type 'int'.
  if (n is int) print(n.value); // Prints 1.
  // Can use 'int' methods on 'n' at run time.
  if (n case int x) print(x.toRadixString(10)); // Prints 1.
  switch (n) {
    case int(:var isEven):
      print("$n (${isEven ? "even" : "odd"})"); // Prints 1 (odd).
  }
}

void main() {
  int i = 2;
  if (i is NumberE) print("It is"); // Prints 'It is'.
  if (i case NumberE v) print("value: ${v.value}"); // Prints 'value: 2'.
  switch (i) {
    case NumberE(:var value):
      print("value: $value"); // Prints 'value: 2'.
  }
}

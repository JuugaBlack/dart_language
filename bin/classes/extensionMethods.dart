// 扩展方法
int.parse('42')
'42'.parseInt()
import 'string_apis.dart';
// ···
print('42'.parseInt()); // Use an extension method.
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
  // ···
}

// 使用扩展方法
// Import a library that contains an extension on String.
import 'string_apis.dart';
// ···
print('42'.padLeft(5)); // Use a String method.
print('42'.parseInt()); // Use an extension method.

// 静态类型和动态类型
// 不能对 类型的变量调用扩展方法dynamic。例如，以下代码会导致运行时异常
dynamic d = '2';
print(d.parseInt()); // Runtime exception: NoSuchMethodError
// 扩展方法确实可以与 Dart 的类型推断配合使用。以下代码很好，因为该变量v被推断为具有类型String
var v = '2';
print(v.parseInt()); // Output: 2

// API冲突
/**如果扩展成员与接口或另一个扩展成员冲突，那么您有几个选择。
一种选择是更改导入冲突扩展的方式，使用show或hide限制公开的 API：
另一种选择是显式应用扩展，这会导致代码看起来就像扩展是包装类：
 */
// Defines the String extension method parseInt().
import 'string_apis.dart';
// Also defines parseInt(), but hiding NumberParsing2
// hides that extension method.
import 'string_apis_2.dart' hide NumberParsing2;
// ···
// Uses the parseInt() defined in 'string_apis.dart'.
print('42'.parseInt());

// Both libraries define extensions on String that contain parseInt(),
// and the extensions have different names.
import 'string_apis.dart'; // Contains NumberParsing extension.
import 'string_apis_2.dart'; // Contains NumberParsing2 extension.

// ···
// print('42'.parseInt()); // Doesn't work.
print(NumberParsing('42').parseInt());
print(NumberParsing2('42').parseInt());
// 如果两个扩展名相同，那么您可能需要使用前缀导入
// Both libraries define extensions named NumberParsing
// that contain the extension method parseInt(). One NumberParsing
// extension (in 'string_apis_3.dart') also defines parseNum().
import 'string_apis.dart';
import 'string_apis_3.dart' as rad;
// ···
// print('42'.parseInt()); // Doesn't work.
// Use the ParseNumbers extension from string_apis.dart.
print(NumberParsing('42').parseInt());
// Use the ParseNumbers extension from string_apis_3.dart.
print(rad.NumberParsing('42').parseInt());
// Only string_apis_3.dart has parseNum().
print('42'.parseNum());

// 实现扩展方法
extension <extension name>? on <type> {
  (<member definition>)*
}
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
  double parseDouble() {
    return double.parse(this);
  }
}

// 未命名的扩展
extension on String {
  bool get isBlank => trim().isEmpty;
}
// 只能在扩展声明中调用未命名扩展的静态成员

// 实现通用扩展
extension MyFancyList<T> on List<T> {
  int get doubleLength => length * 2;
  List<T> operator -() => reversed.toList();
  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}
/*
Numbers (int, double)
Strings (String)
Booleans (bool)
Records ((value1, value2))
Lists (List, also known as arrays)
Sets (Set)
Maps (Map)
Runes (Runes; often replaced by the characters API)
Symbols (Symbol)
The value null (Null)
*/

// var x = 1;
var hex = 0xDEADBEEF;
var y = 1.1;
var exponents = 1.42e5;
num x = 1; // 变量可以同时具有整数和双精度值
x += 2.5;
double z = 1; // 与 double z = 1.0 相等

// 字符串转数字
// String -> int
var one = int.parse('1');
assert(one == 1);
// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);
// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');
// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');

// 按位运算
// 传统的按位移位 ( <<、>>、>>>)、补码 ( ~)、AND ( &)、OR ( |) 和 XOR ( ^) 运算符
assert((3 << 1) == 6); // 0011 << 1 == 0110
assert((3 | 4) == 7); // 0011 | 0100 == 0111
assert((3 & 4) == 0); // 0011 & 0100 == 0000

// 常量
const msPerSecond = 1000;
const secondsUntilRetry = 5;
const msUntilRetry = secondsUntilRetry * msPerSecond;

// 字符串，可以使用单引号或双引号
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
// 使用${expression}来计算表达式的值
var s = 'string interpolation';
assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, '
        'which is very handy.');
assert('That deserves all caps. '
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. '
        'STRING INTERPOLATION is very handy!');
// ==运算符测试两个对象是否等效。如果两个字符串包含相同的代码单元序列，则它们是等效的

// 字符串拼接
var s1 = 'String '
    'concatenation'
    " works even over line breaks.";
assert(s1 ==
    'String concatenation works even over '
        'line breaks.');
var s2 = 'The + operator ' + 'works, as well.';
assert(s2 == 'The + operator works, as well.');

// 多行字符串用三引号
var s1 = '''
You can create
multi-line strings like this one.
''';
var s2 = """This is also a
multi-line string.""";

// 原始字符串
var s = r'In a raw string, not even \n gets special treatment.';

// 只要任何内插表达式是计算结果为 null 或数字、字符串或布尔值的编译时常量，文字字符串就是编译时常量
// const
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';
// not const
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];
const validConstString = '$aConstNum $aConstBool $aConstString';

// bool值
// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);
// Check for zero.
var hitPoints = 0;
assert(hitPoints <= 0);
// Check for null.
var unicorn = null;
assert(unicorn == null);
// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);

// 符文和字素簇
// 在 Dart 中，符文公开字符串的 Unicode 代码点。您可以使用字符包 来查看或操作用户感知的字符，
//也称为 Unicode（扩展）字素簇
import 'package:characters/characters.dart';
void main() {
  var hi = 'Hi 🇩🇰';
  print(hi);
  print('The end of the string: ${hi.substring(hi.length - 1)}');
  print('The last character: ${hi.characters.last}');
}

// 符号
#radix
#bar
// 可调用对象
// 要允许像函数一样调用 Dart 类的实例，请实现该call()方法
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

var wf = WannabeFunction();
var out = wf('Hi', 'there,', 'gang');
void main() => print(out);

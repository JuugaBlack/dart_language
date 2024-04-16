class Television {
  /// 用[turnOn]来打开
  @Deprecated('Use turnOn instead')
  void activate() {
    turnOn();
  }

  /// Turns the TV's power on.
  void turnOn() {...}
  // ···
}
// 所有 Dart 代码都可以使用四种注释： 
// @Deprecated、@deprecated、@override和@pragma
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}
// 继承
// 用extends创建子类，并super引用超类
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
  // ···
}
class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
  // ···
}

// 重写成员
// 子类可以重写实例方法（包括运算符）、getter 和 setter。您可以使用@override注释来表明您有意覆盖成员
class Television {
  // ···
  set contrast(int value) {...}
}
class SmartTelevision extends Television {
  @override
  set contrast(num value) {...}
  // ···
}
/**
 * 重写方法声明必须以多种方式与其重写的方法（或多个方法）相匹配：
 * 返回类型必须与重写方法的返回类型相同（或其子类型）
 * 参数类型必须与重写方法的参数类型相同（或其超类型）。
 * 在前面的示例中，contrast的 setterSmartTelevision 将参数类型从 更改int为超类型num
 * 如果重写的方法接受n 个位置参数，则重写方法也必须接受n 个位置参数
 * 泛型方法不能覆盖非泛型方法，非泛型方法也不能覆盖泛型方法
 */

// noSuchMethod()
// 要在代码尝试使用不存在的方法或实例变量时检测或做出反应，您可以覆盖noSuchMethod()
class A {
  // 除非你重写 noSuchMethod，否则使用不存在的成员会导致 NoSuchMethodError
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}
// 除非满足以下条件之一，否则无法调用未实现的方法 ：
// 接收者具有静态类型dynamic。
// 接收者有一个静态类型，定义了未实现的方法（抽象也可以），而接收者的动态类型有noSuchMethod() 一个与 class 中不同的实现Object。
void main() {
  // 继承
  // 用extends创建子类，并super引用超类
  SmartTelevision smartTV = SmartTelevision();
  smartTV.turnOn(); // 调用 SmartTelevision 类中的 turnOn() 方法

  // 重写成员
  // 子类可以重写实例方法（包括运算符）、getter 和 setter。您可以使用@override注释来表明您有意覆盖成员
  SmartTelevision tv = SmartTelevision();
  tv.contrast = 50; // 调用 SmartTelevision 类中的 contrast setter

  // noSuchMethod()
  // 要在代码尝试使用不存在的方法或实例变量时检测或做出反应，您可以覆盖noSuchMethod()
  A a = A();
  // 调用不存在的方法
  // a.someNonExistentMethod(); // 这将触发 noSuchMethod() 的执行
}

class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }

  void _illuminateDisplay() {
    print('Display illuminated');
  }

  void _activateIrSensor() {
    print('IR sensor activated');
  }
}

class SmartTelevision extends Television {
  @override
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }

  void _bootNetworkInterface() {
    print('Network interface booted');
  }

  void _initializeMemory() {
    print('Memory initialized');
  }

  void _upgradeApps() {
    print('Apps upgraded');
  }

  // 重写成员
  // 子类可以重写实例方法（包括运算符）、getter 和 setter。您可以使用@override注释来表明您有意覆盖成员
  @override
  set contrast(int value) {
    // 重写 contrast setter
    print('Contrast set to $value');
  }
}

class A {
  // noSuchMethod()
  // 要在代码尝试使用不存在的方法或实例变量时检测或做出反应，您可以覆盖noSuchMethod()
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ${invocation.memberName}');
  }
}

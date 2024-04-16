// 混入
// Mixin 是一种定义可在多个类层次结构中重用的代码的方法。它们旨在集体提供成员实现。
//要使用 mixin，请使用with关键字后跟一个或多个 mixin 名称。以下示例显示了两个使用 mixin 的类
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}

// 要定义 mixin，请使用mixin声明。在极少数情况下，您需要同时定义 mixin和类，您可以使用mixin class声明
// Mixins 和 mixin 类不能有extends子句，并且不能声明任何生成构造函数
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;
  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

// 有时您可能想限制可以使用 mixin 的类型
// 可以通过使用on关键字指定所需的超类来限制 mixin 的使用
class Musician {
  // ...
}

mixin MusicalPerformer on Musician {
  // ...
}

class SingerDancer extends Musician with MusicalPerformer {
  // ...
}

// class，mixin， 或者mixin class
// 声明mixin定义了 mixin。声明class定义了一个类。声明mixin class定义了一个类，该类既可以用作常规类，也可以用作混合类，并且具有相同的名称和类型
/**
 * 适用于类或 mixin 的任何限制也适用于 mixin 类：
 * Mixins 不能有extendsorwith子句，所以mixin class.
 * 类不能有on子句，因此mixin class.
 */

// abstract mixin class
abstract mixin class Musician {
  void playInstrument(String instrumentName);
  void playPiano() {
    playInstrument('Piano');
  }

  void playFlute() {
    playInstrument('Flute');
  }
}

class Virtuoso with Musician {
  // Use Musician as a mixin
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }
}

class Novice extends Musician {
  // Use Musician as a class
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }
}

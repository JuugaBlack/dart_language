// 入口主函数
void main() {
  print('Hello, World!');
}

//变量，var可以自动推断类型
var name = 'Voyager I';
var year = 1977;
var antennaDiameter = 3.7;
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
var image = {
  'tags': ['saturn'],
  'url': '//path/to/saturn.jpg'
};

// 控制流语句
if (year >= 2001) {
  print('21st century');
} else if (year >= 1901) {
  print('20th century');
}
for (final object in flybyObjects) {
  print(object);
}
for (int month = 1; month <= 12; month++) {
  print(month);
}
while (year < 2016) {
  year += 1;
}

// 函数
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
var result = fibonacci(20);
flybyObjects.where((name) => name.contains('turn')).forEach(print);

// 导入库
import 'dart:math'; // 导入核心库
import 'package:test/test.dart'; // 从外部包导入库
import 'path/to/my_other_file.dart'; // 导入文件

// 类
class Spacecraft {
  // 属性
  String name;
  DateTime? launchDate;
  int? get launchYear => launchDate?.year;
  Spacecraft(this.name, this.launchDate) {}
  Spacecraft.unlaunched(String name) : this(name, null);

  // 方法
  void describe() {
    print('Spacecraft: $name');
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}
// 类的使用
var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
voyager.describe();
var voyager3 = Spacecraft.unlaunched('Voyager III');
voyager3.describe();

// 枚举类型
enum PlanetType { terrestrial, gas, ice }
enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  // ···
  uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
  neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);
  const Planet(
      {required this.planetType, required this.moons, required this.hasRings});
  final PlanetType planetType;
  final int moons;
  final bool hasRings;
  bool get isGiant =>
      planetType == PlanetType.gas || planetType == PlanetType.ice;
}
final yourPlanet = Planet.earth;
if (!yourPlanet.isGiant) {
  print('Your planet is not a "giant planet".');
}

// 继承
class Orbiter extends Spacecraft {
  double altitude;
  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

// 混入
mixin Piloted {
  int astronauts = 1;
  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}
class PilotedCraft extends Spacecraft with Piloted {
  // ···
}

// 接口、抽象类
class MockSpaceship implements Spacecraft {
  // ···
}
abstract class Describable {
  void describe();
  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

// 异步 async await
const oneSecond = Duration(seconds: 1);
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}
Future<void> printWithDelay(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}
Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print(
            'File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}

// 异常
if (astronauts == 0) {
  throw StateError('No astronauts.');
}
Future<void> describeFlybyObjects(List<String> flybyObjects) async {
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObjects.clear();
  }
}
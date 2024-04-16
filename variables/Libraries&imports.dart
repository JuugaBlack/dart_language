// 以下划线 (_) 开头的标识符仅在库内部可见。每个 Dart 文件（及其部分）都是一个库
// 使用库
import 'dart:html';
import 'package:test/test.dart';
// URI代表统一资源标识符。 URL（统一资源定位符）是一种常见的 URI。

// 指定库前缀
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;
// 使用lib1中的元素。
Element element1 = Element();
// 使用lib2中的元素。
lib2.Element element2 = lib2.Element();

// Import only foo.
import 'package:lib1/lib1.dart' show foo;
// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;

// 延迟加载库
import 'package:greetings/hello.dart' deferred as hello;
Future<void> greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}

// library指令
/// A really great test library.
@TestOn('browser')
library;
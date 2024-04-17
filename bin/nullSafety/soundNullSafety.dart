void main(List<String> args) {
  // Dart 语言要求使用健全的空安全特性
// 空安全会在编译期防止意外访问 null 变量的错误的产生
/**
 * 健全的空安全通过对非空变量的未被初始化或以 null 初始化的情况进行标记，把潜在的 运行时错误 转变成了 编辑时 的分析错误。这样的特性让你在开发应用的过程中就可以修复这类错误：
没有以非空的值初始化
赋了 null 值
 */

// 通过示例代码介绍空安全
// 有了 null 安全性，这些都不能为 null
  var i = 42;
// String name = getFileName();
// final b = Foo();
// 若你想让变量可以为 null，只需要在类型声明后加上 ?
  int? aNullableInt = null;
/**空安全的原则
Dart 的空安全支持基于以下两条核心原则：
默认不可空。除非你将变量显式声明为可空，否则它一定是非空的类型。我们在研究后发现，非空是目前的 API 中最常见的选择，所以选择了非空作为默认值。
完全可靠。Dart 的空安全是非常可靠的，意味着编译期间包含了很多优化。如果类型系统推断出某个变量不为空，那么它 永远 不为空。当你将整个项目和其依赖完全迁移至空安全后，你会享有健全性带来的所有优势—— 更少的 BUG、更小的二进制文件以及更快的执行速度。 
*/
}
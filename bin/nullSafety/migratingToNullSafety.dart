// 迁移至空安全
/**以下是对你的 package 逐个迁移的基本步骤：
1.等待 你依赖的 package 迁移完成。
2.迁移 你的 package 的代码，最好使用交互式的迁移工具。
3.静态分析 package 的代码。
4.测试 你的代码，确保可用。
5.如果你已经在 pub.dev 上发布了你的 package，可以将迁移完成的空安全版本以 预发布 版本进行 发布。
*/
// 理论上，迁移应用和迁移 package 的过程一致。 在迁移应用之前，确保你所依赖的 package 全部迁移完成后，再进行迁移

// 1. 等待迁移
// 切换至 Dart 2.19.6 版本, 检查所有依赖的迁移状态, 升级依赖
// 2. 迁移
// 使用迁移工具, 理解迁移的结果, 改进迁移的结果
void main(List<String> args) {
  var ints = const <int>[0, 1];
  var zero = ints[0];
  var one = zero + 1;
  var zeroOne = <int>[zero, one];
  var ints1 = const <int?>[0, null];
  var zero1 = ints[0];
  var one1 = zero1! + 1;
  var zeroOne1 = <int?>[zero, one1];
  var zero2 = ints[0] /*!*/;

// 首次迁移
  var ints2 = const <int?>[0, 1];
  var zero3 = ints[0];
  var one2 = zero3! + 1;
  var zeroOne2 = <int?>[zero, one2];
// 添加提示后的迁移
  var ints3 = const <int?>[0, 1];
  var zero4 = ints[0] /*!*/;
  var one3 = zero4 + 1;
  var zeroOne3 = <int>[zero, one3];
// 3. 分析
// 4. 测试
// 5. 发布
}

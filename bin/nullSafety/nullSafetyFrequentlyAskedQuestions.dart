/**在迁移代码时，我应该注意哪些运行时的改动？
在空安全迁移中的大部分影响，不会立刻出现在刚刚迁移完成的开发者身上：
静态的空安全检查，会在开发者完成迁移后立刻生效。
完整的空安全检查，只会在所有代码都已迁移，并且启用了完整的空安全模式时生效。
但是有两项例外你需要注意：
对于任何模式而言，! 操作符都是在运行时进行的空检查。所以在进行迁移时，请确保你仅对 null 可能由混合模式造成污染的代码位置添加 !，就算发起调用的代码还未迁移至空安全，也应如此。
late 会在运行时检查。所以请你仅在确定它被使用前一定会被初始化的情况下使用 late。 
*/
void main(List<String> args) {
  // 我应该如何迁移应该为 final 而目前并不是的字段？
  // 用值初始化
// final ListQueue _context = ListQueue<dynamic>();
// final Float32List _buffer = Float32List.fromList([0.0, 0.0]);
// final dynamic _readObject;

// Vec2D(Map<String, dynamic> object) : _readObject = object['container'];

// 我应该如何迁移 built_value 类？
// int? get count; //  Variable initialized with ?

// 我应该如何迁移可能返回 null 的工厂方法？优先使用不返回 null 的工厂方法
  // factory StreamReader(dynamic data) {
  //   if (data is ByteData) {
  //     // Move the readIndex forward for the binary reader.
  //     return BlockReader(data);
  //   } else if (data is Map) {
  //     return JSONBlockReader(data);
  //   } else {
  //     throw ArgumentError('Unexpected type for data');
  //   }
  // }

  // 我应该如何迁移现在提示无用的 assert(x != null)？
  /**对于完全迁移的代码而言，这个断言是不必要的，但是如果你希望保留该检查，那么它 也需要 留下。几种方式可供你选择：
确定是否真的需要这个断言，然后将其删除。当断言启用时，这是一种行为上的变更。
确定断言始终会被检查，接着将其转换为 ArgumentError.checkNotNull。当断言未启用时，这是一种行为上的变更。
通过添加 //ignore: unnecessary_null_comparison 来绕过警告并且保持原有的行为。 
*/

// 我应该如何处理有 setters 的属性？
/**
 * 与上文说到的 late final 的建议不同的是，这些字段不能被标记为终值。通常，可被修改的属性也没有初始值，因为它们可能会在稍后才被赋值。
在这样的情况下，你有两种选择：
为其设置初始值。通常情况下，初始值未被设置是无意的错误，而不是有意为之。
如果你 确定 这个属性需要在访问之前被赋值，将它标记为 late。
注意：late 关键词会在运行时添加检查。如果在 set 之前调用了 get，会在运行时抛出异常。
 */

// 我需要怎样标记映射的返回值为非空类型？
// var result = blockTypes[key];
// if (result != null) return result;
// 在这里处理 null 情况，例如抛出并解释
}

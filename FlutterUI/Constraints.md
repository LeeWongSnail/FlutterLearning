# Constraints

尺寸限制类容易主要用于限制容器的大小，flutter提供了ContrainedBox、SizeBox、UnconstrainedBox、AspectRatio等

## Flutter布局模型

Flutter中有两种布局模型

- 基于RenderBox的盒模型布局
- 基于RenderSliver 按需加载列表布局

布局流程如下:
- 上层组件向下层组件传递约束条件
- 下层组件确定自己的大小，然后告诉上层组件， 下层组件的大小必须符合父组件的约束。
- 上层组件确定下层组件相对于自身的的偏移和确定自身的大小

任何时候子组件都必须先遵守父组件的约束


## BoxConstraints& ConstrainedBox

```dart
ConstrainedBox(
  constraints: BoxConstraints(
    minHeight: 50,
    minWidth: 50,
  ),
  child: Container(
    height: 80,
    color: Colors.red,
  ),
),
```

ConstrainedBox中使用BoxConstraints来设置约束，其中

- minWidth 最小宽度
- maxWidth 最大宽度
- minHeight 最小高度
- maxHeight 最大高度

如果想设置某种固定的宽高我们还可以使用`BoxConstraints.tight(Size size)`方法。如果希望子控件尽可能大的填充另一个容器可以使用 `BoxConstraints.expand()`

## SizedBox

设置一个固定宽高的大小用来限制子元素

```dart
SizedBox(
  width: 100,
  height: 100,
  child: redBox,
),
```
实际上他和`BoxConstraints.tight(Size size)`功能一致。

### 多重限制
如果某一个组件有多个父级的ConstrainedBox限制，那么最终哪一个会生效呢？

```dart
ConstrainedBox(
  constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
  child: ConstrainedBox(
    constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
    child: redBox,
  ),
)
```

我们看到对于redBox这个子控件一共有两个限制

- BoxConstraints(minWidth: 60.0, minHeight: 60.0)
- BoxConstraints(minWidth: 90.0, minHeight: 20.0),

通过展示结果我们发现实际上redBox展示的大小是90*60，我们看到宽度是二级的子视图约束生效而高度是一级父视图约束生效

我们修改下约束:

- BoxConstraints(minWidth: 90.0, minHeight: 20.0),
- BoxConstraints(minWidth: 60.0, minHeight: 60.0),

我们的展示结果依然为90*60，因此我发现
对于设置的最小约束，我们取的是父类视图中较大的那个因为较大的可以同时满足这两个限制，
那么如果是最大呢？
我们猜测会遵守最大限制中较小的哪一个，因为这个也是同时满足两个最大的限制

## UnconstrainedBox

我们上面看到，父控件会约束子控件的约束。一般不会跨层级约束(父控件约束孙子控件)

假如有一个组件 A，它的子组件是B，B 的子组件是 C，
则 C 必须遵守 B 的约束，同时 B 必须遵守 A 的约束，
但是 A 的约束不会直接约束到 C，除非B将A对它自己的约束透传给了C。
利用这个原理，就可以实现一个这样的 B 组件：

1. B 组件中在布局 C 时不约束C（可以为无限大）。
2. C 根据自身真实的空间占用来确定自身的大小。
3. B 在遵守 A 的约束前提下结合子组件的大小确定自身大小。


而这个 B组件就是`UnconstrainedBox` 组件，也就是说`UnconstrainedBox` 的子组件将不再受到约束，大小完全取决于自己。

```dart
ConstrainedBox(
  constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),  //父
  child: UnconstrainedBox( //“去除”父级限制
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
      child: redBox,
    ),
  )
)
```
我们来看下上面这段代码，在第一个ConstrainedBox和第三个ConstrainedBox中间有一层UnconstrainedBox。
根据之前的结论我们应该得到一个90*100的box(min取较大的)。

但是实际上我们得到了一个90*20的box。也就是说`UnconstrainedBox `去掉了`BoxConstraints(minWidth: 60.0, minHeight: 100.0)`的限制，但现实真的是这样吗？

实际并不是,我们通过下图可以发现，实际上父视图中的minHeight=100的限制依然是生效的，但是只是没有影响到孙子类(顶部有间隙)

![flutterui_unconstrainedbox]()

那么有什么方法可以`彻底去除父ConstrainedBox的限制吗`？答案是`否定的`！请牢记，`任何时候子组件都必须遵守其父组件的约束`，所以在此提示读者，在定义一个通用的组件时，如果要对子组件指定约束，那么一定要注意，`因为一旦指定约束条件，子组件自身就不能违反约束`。

在实际开发中，当我们发现已经使用 SizedBox 或 ConstrainedBox给子元素指定了固定宽高，但是仍然没有效果时，几乎可以断定：已经有父组件指定了约束！
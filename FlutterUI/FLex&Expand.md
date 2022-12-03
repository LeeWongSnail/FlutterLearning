# 弹性布局

弹性布局允许子组件按照一定比例来分配父容器空间。

`flutter`中的弹性布局需要`Flex`合`Expand`一起配合实现。

## Flex 

`Flex`组件可以沿着水平或垂直方向排列子组件，如果你知道主轴方向，使用`Row`或`Column`会方便一些，因为`Row`和`Column`都继承自`Flex`，参数基本相同，所以能使用`Flex`的地方基本上都可以使用`Row`或`Column`。

```dart
Flex({
  ...
  required this.direction, //弹性布局的方向, Row默认为水平方向，Column默认为垂直方向
  List<Widget> children = const <Widget>[],
})
```

## Expanded

`expanded`只能作为Flex的子控件使用，他可以按比例扩伸Flex子组件所占用的控件。因为Row和Column都继承自Flex。

```dart
const Expanded({
  int flex = 1, 
  required Widget child,
})
```

flex作为弹性系数，如果是0或者null，则child是没有弹性的，即不会被扩伸占用的空间。如果大于0，所有的Expanded按照flex的比例来分割主轴的全部空闲空间。

下面我们来看下这个例子:

```dart
Flex(direction: Axis.horizontal,
  children: [
    Expanded(child: Container(
      height: 30,
      color: Colors.red,
    ),flex: 1,),
    Expanded(child: Container(
      height: 30,
      color: Colors.green,
    ),flex: 2,),
  ],
),
```
效果如下：

![flutterui_flexexpand]()

我们看到红色和绿色在整个屏幕中按照`1：2`的比例平均分配。色块的高度就是我们设置的高度。

上面还有一个属性direction即方向，上面的例子是`Axis.horizontal`。

下面我们再来看下竖向的情况:

```dart
Padding(padding: EdgeInsets.only(top: 20),
  child: SizedBox(
    height: 100,
    child: Flex(direction: Axis.vertical,
    children: [
      Expanded(child: Container(
        height: 30,
        color: Colors.red,
      ), flex: 2,),
      Spacer(
        flex: 1,
      ),
      Expanded(child: Container(
        height: 60,
        color: Colors.yellow,
      ), flex: 1,)
    ],
    ),
  ),
),
```
这里我们使用到了一个padding用来设置当前的这个控件距离上一个控件的顶部预留一定的间隙。
在当前这个例子中，我们设置`direction: Axis.horizontal`

效果如下：

![flutterui_verticalflexexpanded]()

上述示例中，spacer的功能是占用指定比例的控件，实际上他只是Expanded的一个包装类。





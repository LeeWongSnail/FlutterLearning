# 层叠布局

层叠布局和web中的绝对定位以及移动端的frame布局相似。子组件可以根据距离父容器四个角的位置来确认自己的位置。层叠布局允许子控件按照代码声明的顺序进行堆叠(后声明的会覆盖已声明的)

Flutter中使用stack和Positioned两个组件来配合实现绝对定位。

## stack

```dart
Stack(
    alignment: Alignment.center,
    fit: StackFit.expand,
    children: [
      Positioned(child: Text('I am LeeWong'), left: 20,),
      Container(child: Text('Hello World', style: TextStyle(color: Colors.white),), color: Colors.red,),
    Positioned(child: Text('Your Friends'), top: 20,)
  ],
),
```

展示效果如下:

![flutterui_stack](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_stack.png)

我们来简单介绍下这几个属性:

- alignment 此参数绝对如何对齐没有定位或者部分定位的子控件 共有`topLeft`、`topCenter`、`topRight`、`centerLeft`、`center`、`centerRight`、`bottomLeft`、`bottomCenter`、`bottomRight` 这几个选项

- textDirection 用于确定alignment对齐的参考系。共有`ltr`和`rtl`两种，

- fit 用于确定没有定位的子组件如何去适应stack的大小，共`StackFit.loose`使用子控件大小、`StackFit.expand`扩展到stack大小两个选项。

- clipBehavior: 绝对对超出stack显示控件的部分如何进行裁剪,共有`none`、`hardEdge`、`antiAlias`、`antiAliasWithSaveLayer`几种选项，这里hardEdge表示直接裁剪。

## Positioned

positioned有left/top/right/bottom分别代表stack左、上、右、底四边的距离。width和height用于指定元素的宽度和高度。

如果你想在水平方向指定子控件位置这只需要指定[left/right/width]中的两个就可以。如果三个都指定则会报错。

综上我们来分析下上面代码结果的原因：

- hello world文本没有指定定位，并且alignment的值为center，因此他会居中展示
- i am leewong 只是指定了水平方向的偏移，所以垂直方向会依据alignment来判断居中展示
- Your Friends 只是制定了垂直方向的偏移，所以水平方向会依据alignment来居中展示

上面的代码我们没有设置fit参数，如果我们吧fit设置为StackFit.expand时：

页面展示会变成这样

![flutterui_stack](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_stackerror.png)

fit设置expand则默认子组件的代销扩伸到整个stack的大小。即红色底占满了屏幕 同时遮挡了后驾到父视图上的视图


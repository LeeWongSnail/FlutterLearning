# Container 

这个组件我们之前用过很多次了，这次来详细介绍下他的属性

Container是一个组合类的容器，他包含了我们之前学习过的DecoratedBox/ConstrainedBox/Transform/Padding/Align等组件。

我们先来看下Container的定义：

```dart
Container({
  this.alignment,
  this.padding, //容器内补白，属于decoration的装饰范围
  Color color, // 背景色
  Decoration decoration, // 背景装饰
  Decoration foregroundDecoration, //前景装饰
  double width,//容器的宽度
  double height, //容器的高度
  BoxConstraints constraints, //容器大小的限制条件
  this.margin,//容器外补白，不属于decoration的装饰范围
  this.transform, //变换
  this.child,
  ...
})
```
之前我们已经介绍过 alignment,color,decoration这些属性了，这里只提下面两点：

- width/height和constraint 这两个都可以用来指定容器的size，如果同时存在width和height会优先使用
- color和decoration是互斥的，如果同时设置会报错

## margin、padding

- margin 是表示外边距，表示子组件距离父级组件的间距 是一个EdgeInsets类型
- paddding 表示内边距 表示组件中的元素距离组件边框的间距 

```dart
Container(
  alignment: Alignment.center,
  margin: EdgeInsets.all(100),
  color: Colors.red,
  child: Container(
    padding: EdgeInsets.all(20),
    child: Container(
      color: Colors.yellow
      ,
    ),
  ),
),
```
再来看下效果:

![flutterui_containermargin&padding](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_containermargin%26padding.png)

## 其他属性

```dart
body: Container(
  // 设置外边距
  margin: EdgeInsets.only(top: 50, left: 120),
  // 设置固定大小
  constraints: BoxConstraints.tightFor(width: 200, height: 150),
  // 设置背景
  decoration: BoxDecoration(
  gradient: RadialGradient(colors: [Colors.red, Colors.orange], center: Alignment.topLeft, radius: .8),
  boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2.0, 2.0), blurRadius: 4)],
  ),
  alignment: Alignment.center, // child 在父视图中的位置
  transform: Matrix4.rotationZ(.2), // transform是Matrix4类型的
  child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 40),),
),
```

效果如下：

![flutterui_container](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_container.png)


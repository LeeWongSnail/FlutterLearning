# Transform 

Transform可以在其子组件绘制时对其应用一些矩阵变换来实现一些特效。与iOS中的transform类似

## Transform

```dart
Container(
  color: Colors.black,
  child: Transform(
    alignment: Alignment.bottomLeft,
    transform: Matrix4.skewY(0.3),
    child: Container(
      padding: EdgeInsets.all(10),
      color: Colors.deepOrange,
      child: Text('Hello World'),
    ),
  ),
),
```

## Transform.translate

```dart
          DecoratedBox(decoration: BoxDecoration(color: Colors.red), child: Transform.translate(offset: Offset(-20.0, -5.0), child: Text('Hello World'),),),

```

- offset 可以让child控件，在绘制时沿x,y轴对子组件平移指定距离。

## Transform.rotate

```dart
          DecoratedBox(decoration: BoxDecoration(color: Colors.red), child: Transform.rotate(angle: math.pi/2, child: Text('Hello World'),),),

```

- angle 顺时针的旋转角度

## Transform.scale

```dart
          DecoratedBox(decoration: BoxDecoration(color: Colors.red), child: Transform.scale(scale: 1.5, child: Text('Hello World'),),),

```

- scale 表示子组件的放大或缩小系数

## transform 注意事项

- Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    DecoratedBox(
        decoration:BoxDecoration(color: Colors.red),
        child: Transform.scale(scale: 1.5,
            child: Text("Hello world")
        )
    ),
    Text("你好", style: TextStyle(color: Colors.green, fontSize: 18.0),)
  ],
),
```

- 由于矩阵变化只会作用在绘制阶段，所以在某些场景下，在UI需要变化时，可以直接通过矩阵变化来达到视觉上的UI改变，而不需要去重新触发build流程，这样会节省layout的开销，所以性能会比较好。

## RotatedBox

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    DecoratedBox(decoration: BoxDecoration(
      color: Colors.red
    ), child: RotatedBox(quarterTurns: 1,child: Text('Hello World'),),),
    Text('你好，世界',style: TextStyle(color: Colors.green, fontSize: 18),),
  ],
),
```

RotatedBox是作用于`layout阶段`，所以子组件会旋转90度（而不只是绘制的内容），decoration会作用到子组件所占用的实际空间上.

上述测试代码中的代码效果

![flutterui_transform](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_transorm.png)
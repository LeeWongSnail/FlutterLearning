# 对齐和相对定位 Align

在上一节中我们讲过通过`Stack`和`Positioned`，我们可以指定`一个或多个子元素相对于父元素各个边的精确偏移`，并且可以重叠。但如果我们只想简单的调整一个子元素在父元素中的位置的话，使用Align组件会更简单一些。

我们先附上这一节的整体效果图:

![flutterui_align](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_align.png)

## Align

```dart
Container(
  height: 120,
  width: 120,
  color: Colors.blue.shade50,
  child: Align(
    alignment: Alignment.topCenter,
    child: FlutterLogo(size: 30,),
  ),
),

Container(
  color: Colors.blue.shade50,
  child: Align(
    widthFactor: 4,
    heightFactor: 4,
    alignment: Alignment.topCenter,
    child: FlutterLogo(size: 30,),
  ),
),
```
- alignment 这里我们有两种类型可以选择Alignment或者FractionalOffset 都是表示子控件在父控件中的位置

- widthFactor/heightFactor是用于确定Align组件本身宽高的属性，分别表示宽高的缩放因子，父视图的宽高等于子视图的宽高乘以缩放因子。

## Alignment

用于设置alignment属性

这里有两种写法

```dart

Container(
      color: Colors.blue.shade50,
      child: Align(
        widthFactor: 4,
        heightFactor: 4,
        alignment: Alignment.topCenter,
        child: FlutterLogo(size: 30,),
      ),
    ),
    Container(
      color: Colors.blue.shade50,
      child: Align(
        widthFactor: 4,
        heightFactor: 4,
        alignment: Alignment(0,-1), // (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
    child: FlutterLogo(
      size: 30,
    ),
  ),
),

```

### 枚举写法

共有一下几种选项

- topLeft
- topCenter
- topRight
- centerLeft
- center
- centerRight
- bottomLeft
- bottomCenter
- bottomRight

### 值写法

```dart
Alignment(this.x, this.y)
```
x,y的取值范围是-1--1

这里我们可以通过上面枚举的设置值来了解

```dart
static const Alignment topLeft = Alignment(-1.0, -1.0);

static const Alignment center = Alignment(0.0, 0.0);

static const Alignment bottomRight = Alignment(1.0, 1.0);

```
其实从这几个定义我们就可以看出x,y的坐标原点是矩形中心点，

同时根据上面的设置我们也总结出来了下面这个公式:

```dart
(Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
```
用于计算具体位置

## FractionalOffset

```dart
Container(
  color: Colors.green.shade50,
  width: 120,
  height: 120,
  child: Align(
    alignment: FractionalOffset(0,0),
    child: FlutterLogo(
      size: 30,
    ),
  ),
),
```

这是Alignment的另一中设置方法，他跟Alignment的唯一区别就是坐标系的原点不同

- alignment的原点是矩形的中心店
- FractionalOffset的原点为矩形左侧顶点 实际上跟iOS平时布局计算frame的坐标系是一致的

我们也总结出来了一个公式

```dart
实际偏移 = (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
```

## Align和stack的对比

- 定位参考系统不同；Stack/Positioned定位的的参考系可以是父容器矩形的四个顶点；而Align则需要先通过alignment 参数来确定坐标原点，不同的alignment会对应不同原点，最终的偏移是需要通过alignment的转换公式来计算出。
- Stack可以有多个子元素，并且子元素可以堆叠，`而Align只能有一个子元素，不存在堆叠`。

##  Center组件

```dart
Container(
  color: Colors.yellow.shade50,
  width: 120,
  height: 120,
  child: Center(
    widthFactor: 1,
    heightFactor: 1,
    child: Text('这段文本',),
  ),
),
```

通过头文件定义，我们可以看出Center组件实际就是继承自Align组件，它只是比Align少了一个Alignment参数，因为它默认就是ALignment.center。

## 示例代码

```dart

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Box'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          color: Colors.blue.shade50,
          child: Align(
            alignment: Alignment.topRight,
            child: FlutterLogo(size: 30,),
          ),
        ),
        Container(
          color: Colors.blue.shade50,
          child: Align(
            widthFactor: 4,
            heightFactor: 4,
            alignment: Alignment.topCenter,
            child: FlutterLogo(size: 30,),
          ),
        ),
        Container(
          color: Colors.blue.shade50,
          child: Align(
            widthFactor: 4,
            heightFactor: 4,
            alignment: Alignment(0,-1), // (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
            child: FlutterLogo(
              size: 30,
            ),
          ),
        ),
        Container(
          color: Colors.green.shade50,
          width: 120,
          height: 120,
          child: Align(
            alignment: FractionalOffset(0,0),
            child: FlutterLogo(
              size: 30,
            ),
          ),
        ),
        Container(
          color: Colors.yellow.shade50,
          width: 120,
          height: 120,
          child: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Text('这段文本',),
          ),
        ),
      ],
    ),
  );
}
```

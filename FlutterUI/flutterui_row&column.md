# 线性布局-Row&Column

线型布局即 沿水平或垂直方向排列的子组件。

flutter通过Row和Column来实现线性布局。

## 主轴和纵轴

如果是布局沿水平方向(Row)： 主轴即水平方向，纵轴是垂直方向
如果是布局沿垂直方向(Column): 主轴指垂直方向，纵轴是水平方向

MainAxisAlignment指的是主轴的对齐方向
CrossAxisAlignment 指的是纵轴的对齐方向

## Row

我们先来看下这段代码:

```dart
child: Row(
   // textDirection: TextDirection.rtl,
   // mainAxisSize: MainAxisSize.min,
   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
   verticalDirection: VerticalDirection.up,
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Text('Hello-'),
     Text('This is my number-'),
     Text('Call me maybe-', style: TextStyle(fontSize: 30),),
   ],
)
```
再来看下展示效果:

![flutterui_row](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_row.png)

然后我们分别来介绍下这几个常见的属性:

### textDirection

文字方向设置，共有下面两个选项:

- TextDirection.ltr： left to right 从左向右
- TextDirection.rtl： right to left 从右向左

一般情况下中英文都是从左向右，阿拉伯文为从右向左

### mainAxisSize

主轴方向的大小，有下面两个选项:

- MainAxisSize.min 尽可能的小，这种情况下主轴方向大小由子控件决定
- MainAxisSize.max 尽可能的大

### mainAxisAlignment

主轴的对齐方式，即多个子控件在主轴的对齐方式 有一下几种选项:

- MainAxisAlignment.start 即沿textDirection开始方向对齐
- MainAxisAlignment.end 沿textDirection结束方向对齐
- MainAxisAlignment.center 子控件居中对齐
- MainAxisAlignment.spaceBetween 子控件间距相同 但是第一个的前面和最后一个的后面没有间距
- MainAxisAlignment.spaceAround 子控件之间距离平分，但是第一个的前面和最后一个的后面是子控件之间区域的一半
- MainAxisAlignment.spaceEvenly 空白在子控件之间平分 包含第一个和最后一个子控件前后的区域

### verticalDirection&crossAxisAlignment

表示子组件在纵轴方向的对齐方式。

在Row中主轴是水平方向，纵轴是垂直方向，因此这表示垂直方向的对齐方式，这两个设置互相影响，如果指示值verticalDirection是无效的。

下面我们用这两种组合进行举例

```dart
verticalDirection: VerticalDirection.up,
crossAxisAlignment: CrossAxisAlignment.start,
```
- `verticalDirection: VerticalDirection.up` 表示垂直方向是从下向上
- `crossAxisAlignment: CrossAxisAlignment.start` 表示从开始位置对齐,即底部对齐


```dart
verticalDirection: VerticalDirection.down,
crossAxisAlignment: CrossAxisAlignment.end,
```

- `verticalDirection: VerticalDirection.down`: 表示垂直方向是从上向下
- `crossAxisAlignment: CrossAxisAlignment.end`:表示纵轴对齐是结束方向，即底部对齐


## Column 

Column与Row的属性基本是一致的，但是Row的主轴方向和Column刚好相反，

![flutterui_column](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_column.png)

由于Column和Row刚好相反，因此对于direction相关从垂直方向去考虑。

例如:

```dart
child: Column(
  textDirection: TextDirection.ltr,
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  verticalDirection: VerticalDirection.down,
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    Text('Hello-'),
    Text('This is my number -'),
    Text('Call me maybe', style: TextStyle(fontSize: 30),),
  ],
)
```

- mainAxisSize 表示垂直方向的高度 是尽可能的大 还是依赖子控件决定
- mainAxisAlignment 也是表示垂直方向的间距分布
- verticalDirection& crossAxisAlignment的组合不再表示垂直方向顶部还是底部，而是指水平方向左边还是右边

## 嵌套

我们看到无论是Row还是Column其中都有一个mainAxisSize即主轴方向的大小。

如果我们发生嵌套呢？我们先来看下下面这段示例:

```dart
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
  children: <Widget>[
    Container(
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,//无效，内层Colum高度为实际高度  
        children: <Widget>[
          Text("hello world "),
          Text("I am Jack "),
        ],
      ),
    )
  ],
),
```

效果如下:

![flutterui_rowembed](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_rowembed.png)

我们可以看到，第一层Column中设置了`mainAxisSize: MainAxisSize.max`是有效的因为在垂直方向，的确是占据了整个屏幕的高度，但是第二层Column的`mainAxisSize: MainAxisSize.max`实际没有其作用，其实际高度就是子控件的高度。

因此 如果想在嵌套时子Column的高度占据父Column的高度，那么中间不能直接嵌套需要加一层，例如Expand,我们先直接看效果，

```dart
 child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
  children: <Widget>[
    Expanded(child: Container(
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,//无效，内层Colum高度为实际高度
        children: <Widget>[
          Text("hello world "),
          Text("I am Jack "),
        ],
      ),
    )),
  ],
),
```
实际效果如下:

![flutterui_columnembedfixexpand](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_columnembedfixexpand.png)

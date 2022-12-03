# 流式布局(Wrap Flow)

在介绍Row和Column时，如果子Widget超出屏幕范围，则会报出溢出错误，如:

```dart
Row(
  children: <Widget>[
    Text("LeeWong"*100)
  ],
);
```

![flutter_rowoverflow]()

我们看到当，右边溢出部分报错。这是因为Row默认只有一行，如果超出屏幕不会折行。我们把超出屏幕显示范围会自动折行的布局称为流式布局。

Flutter中通过Wrap和Flow来支持流式布局，将上例中的Row换成Wrap移除部分则会自动折行。

![flutterui_wrapfixoverflow]()

## Wrap

```dart
body: Wrap(
	spacing: 8.0,
	runSpacing: 4.0,
	alignment: WrapAlignment.center,
	children: [
		Chip(label: Text('Hamilton'),
			avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),),
		Chip(label: Text('Lafayette'),
			avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M'),),),
		Chip(label: Text('Mulligan'),
			avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H'),),),
		Chip(label: Text('Laurens'),
			avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J'),),)
		],
),
```
效果如下

![flutterui_wrap]()

## Flow

一般我们很少使用Flow,因为其需要自己实现子Widget位置转换。

在很多场景下首先要考虑的是Wrap是否满足需求。Flow主要用于一些需要自定义布局策略或性能要求较高的场景。

优点:

- 性能更好；Flow是一个对子组件尺寸以及位置调整非常高效的控件，主要通过FlowDelegate中的paintChildren()中方法调用context.paintChild进行重绘，而context.paintChild在重绘时使用转换矩阵，并没有实际调整组件位置。

- 灵活; 我们需要自己计算每一个组件的位置。

缺点:
- 使用复杂
- Flow不能自适应子组件大小，必须通过制定父容器视图大小或者实现TestFlowDelegate的getSize返回固定大小。

```dart
Flow(
  delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
  children: <Widget>[
    Container(width: 80.0, height:80.0, color: Colors.red,),
    Container(width: 80.0, height:80.0, color: Colors.green,),
    Container(width: 80.0, height:80.0, color: Colors.blue,),
    Container(width: 80.0, height:80.0,  color: Colors.yellow,),
    Container(width: 80.0, height:80.0, color: Colors.brown,),
    Container(width: 80.0, height:80.0,  color: Colors.purple,),
  ],
)

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
    var x = margin.left;
    var y = margin.top;
    // 计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if(w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        // 绘制子widget
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    // 指定flow的大小，简单起见我们让宽度尽可能的大，但高度指定为200
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置flow大小
    return Size(double.infinity, 250);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }

}
```

效果如下：

![flutterui_flowpaint]()

这里我们自定义了一个类，这个类继承自TestFlowDelegate，主要任务是实现`paintChildren`,他的主要任务是确定每个子Widget位置。

由于不能自适应`widget`的大小，我们通过在`getSize`返回一个固定大小来指定`Flow`的大小。

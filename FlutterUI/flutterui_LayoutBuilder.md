# LayoutBuilder

通过LayoutBuilder，我们可以在布局过程中拿到父组件传递的约束信息，然后我们可以根据父组件的约束信息对子组件进行动态布局。

我们先来看下下面这个例子

创建一个响应式的ResponsiveColumn,当父组件宽度大于200时展示两列，当父组件宽度小于200时展示一列。

```dart

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List <Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 200) {
        // 最大的宽度小于200 则显示单列
        return Column(children: children, mainAxisSize: MainAxisSize.min,);
      } else {
        // 最大宽度大于200 则展示双列
        // 这里需要将数据拆分成一行两列的形式
        var _children = <Widget>[];
        for(var i = 0; i < children.length; i = i+2) {
          // 需要判断是否还存在下一个
          if (i+1 < children.length) {
            // 还有下一个
            _children.add(Row(
              children: [children[i], children[i+1]],
              mainAxisSize: MainAxisSize.min,
            ));
          } else {
            _children.add(children[i]);
          }
        }
        return Column(children: _children, mainAxisSize: MainAxisSize.min,);
      }
    });
  }
}


class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, Text('A'));
    // Column 在本市李忠在水平方向的最大宽度为屏幕的宽度
    return Column(
      children: [
        Container(width: 100, height: 100,),
        SizedBox(width: 190, child: ResponsiveColumn(children: _children,),),
        ResponsiveColumn(children: _children),
        LayoutLogPrint(child: Text('AA')), 
		//flutter: Text("AA"): BoxConstraints(0.0<=w<=393.0, 0.0<=h<=Infinity)
      ],
    );
  }
}
```

我们先来看下上述代码的展示效果:

![flutterui_layoutbuilder]()

实际上在我们需要自定义布局时，LayoutBuilder非常实用，实用起来也很简单，他类似于iOS中的collectionView,而我们的LayoutBuilder类似于CollectionView的Layout。 它主要有两个实用场景:

- 可以使用LayoutBuilder来根据设备的尺寸来实现响应式布局
- LayoutBuilder可以帮我们高效的排查问题。
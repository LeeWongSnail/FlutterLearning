# CustomScrollView 和 Slivers

在开始了解本章节之前我们在看下下面两个概念:

### Sliver

表示可滚动布局中的一部分，它的 child 可以是普通的 Box Widget。

### ViewPort

- ViewPort 是一个显示窗口，它内部可包含多个 Sliver；
- ViewPort 的宽高是确定的，它内部 Slivers 的宽高之和是可以大于自身的宽高的；
- ViewPort 为了提高性能采用懒加载机制，它只会绘制可视区域内容 Widget。

可以通过下面这种图来了解下viewPort和sliver的关系

![sliver&viewport](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/5/12/172087a995e51ba4~tplv-t2oaga2asx-zoom-in-crop-mark:4536:0:0:0.image)

### ScrollPostion

决定了 Viewport 哪些区域是可见的，它包含了Viewport 的滚动信息

```dart
abstract class ScrollPosition extends ViewportOffset with ScrollMetrics {
  // 滚动偏移量
  double _pixels;
  // 设置滚动响应效果，比如滑动停止后的动画
  final ScrollPhysics physics;
  // 保存当前的滚动偏移量到 PageStore 中，当 Scrollable 重建后可以恢复到当前偏移量
  final bool keepScrollOffset;
  // 最小滚动值
  double _minScrollExtent;
  // 最大滚动值
  double _maxScrollExtent;
  ...
}

```

### Scrollable

Scrollable 是一个可滚动的 Widget，它主要负责：

- 监听用户的手势，计算滚动状态发出 Notification
- 计算 offset 通知 listeners

Scrollable 本身不具有绘制内容的能力，它通过构造注入的 viewportBuilder 来创建一个 Viewport 来显示内容，当滚动状态变化的时候，Scrollable 就会不断的更新 Viewport 的 offset ，Viewport 就会不断的更新显示内容。


## CustomScrollView

在某些复杂的页面我们会用到多个滚动视图嵌套的情况，比如

```
 Widget buildTwoListView() {
    var listView = ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) => ListTile(title: Text('$index')),
    );
    return Column(
      children: [
        Expanded(child: listView),
        Divider(color: Colors.grey),
        Expanded(child: listView),
      ],
    );
  }
}
```
这当前页面中，我们有两个listView,这两个listView各占屏幕的一半，我们发现直接这么写的话这两个listView是互相独立的，当手势在组件对应的响应区域时，对应的组件会响应滚动手势，但是这两个listView是无法关联的(当第一个listView滚动到底部时自动触发下一个listView的滚动)

我们知道一个完整的可滚动组件包含: Scrollable, ViewPort, Sliver. 所以在上面的例子中两个list各自拥有自己的Scrollable, ViewPort, Sliver。因此无法关联。

如果我们希望这两个listView可以关联起来，那我们就需要让这两个组件拥有共同的Scrollable, ViewPort。

Flutter提供了`CustomScrollView `来帮我们组件一个公共的Scrollable, ViewPort。

```dart
Widget buildTwoSliverList() {
  // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
  // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList 
  // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
  var listView = SliverFixedExtentList(
    itemExtent: 56, //列表项高度固定
    delegate: SliverChildBuilderDelegate(
      (_, index) => ListTile(title: Text('$index')),
      childCount: 10,
    ),
  );
  // 使用
  return CustomScrollView(
    slivers: [
      listView,
      listView,
    ],
  );
}
```

通过使用`CustomScrollView`，我们就可以实现我们想要的效果了。

## Flutter中常用的Sliver

| Sliver名称  | 功能  | 对应的可滚动组件  |
|:----------|:----------|:----------|
| SliverList    | 列表    | ListView    |
| SliverFixedExtentList    | 高度固定的列表    | ListView ，指定itemExtent时   |
| SliverAnimatedList    | 添加/删除列表项可以执行动画    | AnimatedList    |
| SliverGrid    | 网格    | GridView    |
| SliverPrototypeExtentList    | 根据原型生成高度固定的列表    | ListView，指定prototypeItem 时    |
| SliverFillViewport    | 包含多个子组件，每个都可以填满屏幕    | PageView    |

除了和列表对应的Sliver之外还有一些对Sliver进行布局和装饰的组件

| Sliver名称  | 对应 RenderBox  |
|:----------|:----------|
| SliverPadding    | Padding    |
| SliverVisibility、SliverOpacity	    | Visibility、Opacity   |
| SliverFadeTransition    | FadeTransition    |
| SliverLayoutBuilder    | LayoutBuilder    |

还有一些其他常用的Sliver:

| Sliver名称	  | 说明  |
|:----------|:----------|
| SliverAppBar    | 对应 AppBar，主要是为了在 CustomScrollView 中使用。   |
| SliverToBoxAdapter	    | 一个适配器，可以将 RenderBox 适配为 Sliver，后面介绍。    |
| SliverPersistentHeader    | 滑动到顶部时可以固定住，后面介绍。|

`重点`:CustomScrollView的子组件必须都是Sliver。

根据上面的描述我们来写一个简单的页面

```dart
class _CustomScrollViewWidgetState extends State<CustomScrollViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(slivers: [
        // SliverToBoxAdapter(
        //   child: SizedBox(height: 300,child: PageView(
        //     children: [Text('1'),Text('2')],
        //   ),),
        // ),
        SliverAppBar(pinned: true,expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(title: Text('SliverAppBar'), background: Image.asset("/Users/LeeWong/StudioProjects/flutter_ui/images/light.png", fit: BoxFit.cover,),),),
        SliverPadding(padding: EdgeInsets.all(8.0), sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0, childAspectRatio: 4.0),
          delegate: SliverChildBuilderDelegate((BuildContext context, int index){
            return Container(alignment: Alignment.center, color: Colors.cyan[100*(index%9)], child: Text('gridItem $index'),);
          }, childCount: 20),
        ),),
        SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center, color: Colors.lightBlue[100*index%9],child: Text('list item $index'),
            );
          },
          childCount: 20,
        ), itemExtent: 50.0)
      ],),
    );
  }
}
```

![flutterui_CustomScrollView]()

- 头部SliverAppBar：SliverAppBar对应AppBar，两者不同之处在于SliverAppBar可以集成到CustomScrollView。SliverAppBar可以结合FlexibleSpaceBar实现Material Design中头部伸缩的模型，具体效果，读者可以运行该示例查看。

- 中间的SliverGrid：它用SliverPadding包裹以给SliverGrid添加补白。SliverGrid是一个两列，宽高比为4的网格，它有20个子组件。

- 底部SliverFixedExtentList：它是一个所有子元素高度都为50像素的列表。
		
		
## SliverToBoxAdapter

上面介绍了很多Sliver的组件，但是在我们日常开发中经常会向CustomScrollView中添加自定义类型的组件，那么这时候我们如何保证这些组件是Sliver的呢？

Flutter提供了SliverToBoxAdapter 组件，它是一个适配器：可以将 RenderBox 适配为 Sliver。

例如:

```dart
CustomScrollView(
  slivers: [
    SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: PageView(
          children: [Text("1"), Text("2")],
        ),
      ),
    ),
    buildSliverFixedList(),
  ],
);
```		
		
`注意`: 这里我们添加的PageView默认是左右滚动的，所以我们上面的代码和之前的CustomScrollView是兼容的，展示和交互都没有问题，但是如果我们将PageView的滚动方向改为竖向(与CustomScrollView滚动方向一致)那么就会有问题。

原因是：CustomScrollView 组合 Sliver 的原理是为所有子 Sliver 提供一个共享的 Scrollable，然后统一处理指定滑动方向的滑动事件，如果 Sliver 中引入了其他的 Scrollable，则滑动事件便会冲突。

#### 结论

如果 CustomScrollView 有孩子也是一个完整的可滚动组件且它们的滑动方向一致，则 CustomScrollView 不能正常工作。

## SliverPersistentHeader

SliverPersistentHeader 的功能是当滑动到 CustomScrollView 的顶部时，可以将组件固定在顶部。

类似iOS中UITableView的sectionHeader当tableView的style设置为plain时，header会有悬停的效果。比较常见的使用场景如通讯录。

我们先来看下定义:

```dart
const SliverPersistentHeader({
  Key? key,
  // 构造 header 组件的委托
  required SliverPersistentHeaderDelegate delegate,
  this.pinned = false, // header 滑动到可视区域顶部时是否固定在顶部
  this.floating = false, // 正文部分介绍
})
```

- floating 的做用是：pinned 为 false 时 ，则 header 可以滑出可视区域（CustomScrollView 的 Viewport）（不会固定到顶部），当用户再次向下滑动时，此时不管 header 已经被滑出了多远，它都会立即出现在可视区域顶部并固定住，直到继续下滑到 header 在列表中原来的位置时，header 才会重新回到原来的位置（不再固定在顶部）。

- delegate 是用于生成 header 的委托，类型为 SliverPersistentHeaderDelegate，它是一个抽象类，需要我们自己实现

```dart
abstract class SliverPersistentHeaderDelegate {

  // header 最大高度；pined为 true 时，当 header 刚刚固定到顶部时高度为最大高度。
  double get maxExtent;
  
  // header 的最小高度；pined为true时，当header固定到顶部，用户继续往上滑动时，header
  // 的高度会随着用户继续上滑从 maxExtent 逐渐减小到 minExtent
  double get minExtent;

  // 构建 header。
  // shrinkOffset取值范围[0,maxExtent],当header刚刚到达顶部时，shrinkOffset 值为0，
  // 如果用户继续向上滑动列表，shrinkOffset的值会随着用户滑动的偏移减小，直到减到0时。
  //
  // overlapsContent：一般不建议使用，在使用时一定要小心，后面会解释。
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent);
  
  // header 是否需要重新构建；通常当父级的 StatefulWidget 更新状态时会触发。
  // 一般来说只有当 Delegate 的配置发生变化时，应该返回false，比如新旧的 minExtent、maxExtent
  // 等其他配置不同时需要返回 true，其余情况返回 false 即可。
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate);

  // 下面这几个属性是SliverPersistentHeader在SliverAppBar中时实现floating、snap 
  // 效果时会用到，平时开发过程很少使用到，读者可以先不用理会。
  TickerProvider? get vsync => null;
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration => null;

}
```

下面我们来实现一个`SliverPersistentHeader`

```dart

class PersistentHeaderRoute extends StatelessWidget {
  const PersistentHeaderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sliver PersistentHeader'),),
      body: CustomScrollView(
        slivers: [
          buildSliverList(),
          SliverPersistentHeader(pinned: true, delegate: SliverHeaderDelegate(maxHeight: 80, minHeight: 50, child: buildHeader(1))),
          buildSliverList(),
          SliverPersistentHeader(pinned: true, delegate: SliverHeaderDelegate.fixHeight(height: 50, child: buildHeader(2))),
          buildSliverList(20)
        ],
      ),
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 50), itemExtent: 50, );
  }

  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade100,
      alignment: Alignment.centerLeft,
      child: Text('PersistentHeader $i'),
    );
  }
}


typedef SliverHeaderBuilder = Widget Function(BuildContext context, double shrinkOffset, bool overlapContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  SliverHeaderDelegate({
    required this.maxHeight, this.minHeight = 0, required Widget child,
  }) : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);


  SliverHeaderDelegate.fixHeight({
    required double height,
    required Widget child,
  }) : builder = ((a,b,c) => child),
        maxHeight = height,
        minHeight = height;

  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    Widget child = builder(context, shrinkOffset, overlapsContent);
    assert(() {
      if(child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    return SizedBox.expand(child: child,);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;
  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  }
}
```

效果如下:

![flutterui_SliverPersistentHeader]()

`注意`:

- 当有多个 SliverPersistentHeader时，需要注意第一个 SliverPersistentHeader 的 overlapsContent 值会一直为 false。

## 总结

- CustomScrollView 组合 Sliver 的原理是为所有子 Sliver 提供一个共享的 Scrollable，然后统一处理指定滑动方向的滑动事件。

- CustomScrollView 和 ListView、GridView、PageView 一样，都是完整的可滚动组件（同时拥有 Scrollable、Viewport、Sliver）。

- CustomScrollView 只能组合 Sliver，如果有孩子也是一个完整的可滚动组件（通过 SliverToBoxAdapter 嵌入）且它们的滑动方向一致时便不能正常工作。

## 参考文献

[Flutter - 循序渐进 Sliver](https://juejin.cn/post/6844904155195129864)
# TabBarView

首先我们看下这个空间的样式:

![flutterui_tabbarView]()

下面我们再来看下这个空间的声明

```dart
 const TabBarView({
    super.key,
    required this.children, // tab页
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  })
```

`注意`: TabbarView是指中间部分的可滚动区域，一般配合TabBarView使用的另一个控件为TabBar，即展示标题的控件。

## TabBar

```dart
const TabBar({
  Key? key,
  required this.tabs, // 具体的 Tabs，需要我们创建
  this.controller,
  this.isScrollable = false, // 是否可以滑动
  this.padding,
  this.indicatorColor,// 指示器颜色，默认是高度为2的一条下划线
  this.automaticIndicatorColorAdjustment = true,
  this.indicatorWeight = 2.0,// 指示器高度
  this.indicatorPadding = EdgeInsets.zero, //指示器padding
  this.indicator, // 指示器
  this.indicatorSize, // 指示器长度，有两个可选值，一个tab的长度，一个是label长度
  this.labelColor, 
  this.labelStyle,
  this.labelPadding,
  this.unselectedLabelColor,
  this.unselectedLabelStyle,
  this.mouseCursor,
  this.onTap,
  ...
}) 
```
这两个控件的关联是通过设置两个控件的controller属性，进行关联。即点击tab tabbarview滚动，滚动tabbarView，tab切换。

## 实例

```dart

class TabViewRoute extends StatefulWidget {
  const TabViewRoute({Key? key}) : super(key: key);

  @override
  _TabViewRouteState createState() => _TabViewRouteState();
}

class _TabViewRouteState extends State<TabViewRoute> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List tabs = ['新闻','历史','图片'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TabBarView'),
        bottom: TabBar(controller: _tabController, tabs: tabs.map((e) => Tab(text: e,)).toList(),),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5,),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
```

如果我们不想通过一个controller属性(代码中的`_tabController`)来关联这两个控件实现联动，我们可以创建一个DefaultTabController作为他们的共同父控件，这样他们在执行时就会从组件树向上查找，都会找到我们指定的DefaultTabController。

```dart
class TabViewRoute2 extends StatelessWidget {
  const TabViewRoute2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = ['新闻','历史','图片'];
    return DefaultTabController(length: tabs.length, child: Scaffold(
      appBar: AppBar(title: Text('TabBarView2'),
        bottom: TabBar(tabs: tabs.map((e) => Tab(text: e,)).toList(),),
      ),
      body: TabBarView(
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, textScaleFactor: 5,),
          );
        }).toList(),
      ),
    ));
  }
}
```
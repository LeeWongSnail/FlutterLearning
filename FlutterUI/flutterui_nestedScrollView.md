# NestedScrollView

前面的文章中我们遇到一个嵌套的滚动视图，如果两个滚动视图的滚动方向一致，可能会导致问题，这篇文章我们来介绍一个组件`NestedScrollView `专门用来处理刚才的这种场景

## NestedScrollView

我们先来看下结构

```dart
const NestedScrollView({
  ... //省略可滚动组件的通用属性
  //header，sliver构造器
  required this.headerSliverBuilder,
  //可以接受任意的可滚动组件
  required this.body,
  this.floatHeaderSlivers = false,
}) 
```
这个结构很明显与iOS中的tableView有点类似 尤其是这个空间中预留了一个`headerSliverBuilder`组件，以及一个body组件。

下面我么来看下这个示例:

```dart
class NestedTabBarView extends StatelessWidget {
  const NestedTabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabs = ['猜你喜欢','今日特价', '发现更多'];
    return DefaultTabController(length: _tabs.length, child: Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: Text('商城'),
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: _tabs.map((e) => Tab(text: e,)).toList(),
              ),
            ),),
          ];
        },
        body: TabBarView(
          children: _tabs.map((e) {
            return Builder(builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey(e),
                slivers: [
                  SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                  SliverPadding(padding: EdgeInsets.all(8),sliver: buildSliverList(),),
                ],
              );
            });
          }).toList(),
        ),
      ),
    ));
  }

  Widget buildSliverList() {
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 100), itemExtent: 56);
    return listView;
  }
}
```
效果如下:

![flutterui_nestedScrollView]()

## 原理

首先我们来看下结构图:

![flutterui_NestedScrollView]()

- NestedScrollView 整体就是一个 CustomScrollView

- header 和 body 都是 CustomScrollView 的子 Sliver ，注意，虽然 body 是一个 RenderBox，但是它会被包装为 Sliver。

- CustomScrollView 将其所有子 Sliver 在逻辑上分为 header 和 body 两部分：header 是前面部分、body 是后面部分。

- 当 body 是一个可滚动组件时， 它和 CustomScrollView 分别有一个 Scrollable ，由于 body 在 CustomScrollView 的内部，所以称其为内部可滚动组件，称 CustomScrollView 为外部可滚动组件；同时 因为 header 部分是 Sliver，所以没有独立的 Scrollable，滑动时是受 CustomScrollView 的 Scrollable 控制，所以为了区分，可以称 header 为外部可滚动组件（Flutter 文档中是这么约定的）

- NestedScrollView 核心功能就是通过一个协调器来协调外部可滚动组件和内部可滚动组件的滚动，以使滑动效果连贯统一，协调器的实现原理就是分别给内外可滚动组件分别设置一个 controller，然后通过这两个controller 来协调控制它们的滚动。


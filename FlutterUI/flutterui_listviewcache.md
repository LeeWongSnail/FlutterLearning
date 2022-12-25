# 可滚动组件子项缓存

在上一篇文章中我们介绍gridView,gridview默认是没有缓存的，我们只能通过设置`allowImplicitScrolling`属性来实现至多2个页面的缓存。

这篇文章我们来介绍下如何自己实现页面的缓存。


## AutomaticKeepAlive

AutomaticKeepAlive 的组件的主要作用是将列表项的根 RenderObject 的 keepAlive 按需自动标记 为 true 或 false。

我们将列表组件的 `Viewport区域 + cacheExtent（预渲染区域）称为加载区域`

- 当 keepAlive 标记为 false 时，如果列表项滑出加载区域时，列表组件将会被销毁。
- 当 keepAlive 标记为 true 时，当列表项滑出加载区域后，Viewport 会将列表组件缓存起来；当列表项进入加载区域时，Viewport 从先从缓存中查找是否已经缓存，如果有则直接复用，如果没有则重新创建列表项。

那么 AutomaticKeepAlive 什么时候会将列表项的 keepAlive 标记为 true 或 false 呢？

子组件想改变是否需要缓存的状态时就向 AutomaticKeepAlive 发一个通知消息（KeepAliveNotification），AutomaticKeepAlive 收到消息后会去更改 keepAlive 的状态，如果有必要同时做一些资源清理的工作（比如 keepAlive 从 true 变为 false 时，要释放缓存）。

对于上一节的例子我们只需要稍作修改就可以实现缓存。

```dart
class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用
    return Center(child: Text("${widget.text}", textScaleFactor: 5));
  }

  @override
  bool get wantKeepAlive => true; // 是否需要缓存
}
```

我们只需要提供一个 wantKeepAlive，它会表示 AutomaticKeepAlive 是否需要缓存当前列表项；另外我们必须在 build 方法中调用一下 super.build(context)，该方法实现在 AutomaticKeepAliveClientMixin 中，功能就是根据当前 wantKeepAlive 的值给 AutomaticKeepAlive 发送消息，AutomaticKeepAlive 收到消息后就会开始工作.

## KeepAliveWrapper 

这是其他小伙伴基于KeepAlive实现的另一种更优雅的方式

```dart

// Tab 页面
class Page extends StatefulWidget {
  const Page({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    return Center(child: Text("${widget.text}", textScaleFactor: 5));
  }
}

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({Key? key, this.keepAlive = true, required this.child}) : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    // TODO: implement didUpdateWidget
    if(oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => widget.keepAlive;
}


class KeepAliveTest extends StatelessWidget {
  const KeepAliveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_, index){
      // 为 true 后会缓存所有的列表项，列表项将不会销毁。
      // 为 false 时，列表项滑出预加载区域后将会别销毁。
      // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
      return KeepAliveWrapper(child: ListItem(index: index,), keepAlive: true,);
    });
  }
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('${widget.index}'),);
  }

  @override
  void dispose() {
    print('dispose ${widget.index}');
    // TODO: implement dispose
    super.dispose();
  }
}
```

![flutterui_keepalive](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_listviewcache.gif)
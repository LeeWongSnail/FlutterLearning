# PageView

在iOS开发中当我们在某些场景下使用CollectionView或者PageViewController,这种容器视图，且单个视图是整个屏幕，这种情况下对应的是flutter的PageView

下面我们来看下pageView

```dart
PageView({
  Key? key,
  this.scrollDirection = Axis.horizontal, // 滑动方向
  this.reverse = false,
  PageController? controller,
  this.physics,
  List<Widget> children = const <Widget>[],
  this.onPageChanged,
  
  //每次滑动是否强制切换整个页面，如果为false，则会根据实际的滑动距离显示页面
  this.pageSnapping = true,
  //主要是配合辅助功能用的，后面解释
  this.allowImplicitScrolling = false,
  //后面解释
  this.padEnds = true,
})
```

我们来写一个简单的例子:

```dart
class PagingView extends StatefulWidget {
  const PagingView({Key? key}) : super(key: key);

  @override
  _PagingViewState createState() => _PagingViewState();
}

class _PagingViewState extends State<PagingView> {
  @override
  Widget build(BuildContext context) {

    var children = <Widget>[];
    for(int i = 0; i < 6; i++) {
      children.add(Page(text: '${i}'));
    }

    return Scaffold(appBar: AppBar(title: Text('PageView'),),
      body: PageView(children: children,scrollDirection: Axis.vertical,allowImplicitScrolling: true,),
    );
  }
}



class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print('build ${widget.text}');
    return Center(child: Text("${widget.text}", textScaleFactor: 5,),);
  }
}
```

效果如下

![flutterui_pageview](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_pageview.gif)

上面的PageView中每一页都只有一个数字，滚动的时候会调用build方法，我们可以在滚动的时候观察控制台输出print。

当我们关注控制台时，我们发现，每次滚动都会有输出

```
flutter: build 3
flutter: build 2
flutter: build 1
```
可见，PageView不想ListView或者GridView一样默认是有缓存的，

当我们去查看PageView的源码时，我们发现:

```dart
child: Scrollable(
  ...
  viewportBuilder: (BuildContext context, ViewportOffset position) {
    return Viewport(
      // TODO(dnfield): we should provide a way to set cacheExtent
      // independent of implicit scrolling:
      // https://github.com/flutter/flutter/issues/45632
      cacheExtent: widget.allowImplicitScrolling ? 1.0 : 0.0,
      cacheExtentStyle: CacheExtentStyle.viewport,
      ...
    );
  },
)
```
我们可以通过设置`widget.allowImplicitScrolling `来设置`cacheExtent`。cacheExtent 为 1.0，则代表前后各缓存一个页面宽度，即前后各一页。

通过设置我们在滚动页面的时候观察控制台的输出，也可以验证这个结果，

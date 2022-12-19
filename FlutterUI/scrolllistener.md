# 滚动监听

在上面介绍ListView时，我们了解到，ListView有一个ScrollController可以用来控制滚动组件的滚动位置。

## ScrollController

```dart

class ScrollControllerTestRoute extends StatefulWidget {
  const ScrollControllerTestRoute({Key? key}) : super(key: key);

  @override
  _ScrollControllerTestRouteState createState() => _ScrollControllerTestRouteState();
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {

  ScrollController _scrollController = ScrollController();

  // 是否展示回到顶部按钮
  bool showToTopBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('滚动监听'),),
      body: Scrollbar(
        child: ListView.builder(itemBuilder: (context, index){
          return ListTile(title: Text('$index'),);
        }, itemCount: 100,itemExtent: 50, controller: _scrollController,),
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(onPressed: (){
        _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
      }, child: Icon(Icons.arrow_upward),),
    );
  }
}
```

![flutterui_scrolllistener]()

这里我们是使用了scrollController的方式，我们在initState方法中添加监听者

```dart
_scrollController.addListener(() {
    print(_scrollController.offset);
});
```

这时候我们可以根据设定的阈值1000进行我们对应的操作

## 滚动位置恢复

PageStorage，用于保存页面陆游相关数据的组件，它拥有一个存储桶。

每次滚动结束，可滚动组件都会讲位置offset存储到PageStorage中，当可滚动组件重新创建时，再恢复。也可以通过设置`ScrollController.keepScrollOffset`为`false`,则滚动位置将不会被存储.


## ScrollPosition

ScrollPosition是用来保存可滚动组件的滚动位置的。

一个ScrollController对象可以同时被多个可滚动组件使用，ScrollController会为每一个可滚动组件创建一个ScrollPosition对象，这些ScrollPosition保存在ScrollController的positions属性中（List<ScrollPosition>）

ScrollPosition的方法

- animateTo() 
- jumpTo()

##  ScrollController控制原理

- 当ScrollController和可滚动组件关联时，可滚动组件首先会调用ScrollController的createScrollPosition()方法来创建一个ScrollPosition来存储滚动位置信息

- 接着，可滚动组件会调用attach()方法，将创建的ScrollPosition添加到ScrollController的positions属性中，这一步称为“注册位置”，只有注册后animateTo() 和 jumpTo()才可以被调用。

- 当可滚动组件销毁时，会调用ScrollController的detach()方法，将其ScrollPosition对象从ScrollController的positions属性中移除，这一步称为“注销位置”，注销后animateTo() 和 jumpTo() 将不能再被调用。


## 滚动监听

`Flutter Widget`树中子`Widget`可以通过发送通知`（Notification`）与父(包括祖先`Widget`通信。父级组件可以通过`NotificationListener`组件来监听自己关注的通知，这种通信方式类似于`Web`开发中浏览器的`事件冒泡`，我们在`Flutter`中沿用“冒泡”这个术语，关于通知冒泡我们将在后面“事件处理与通知”一章中详细介绍。

`可滚动组件`在`滚动时`会`发送``ScrollNotification`类型的`通知`，`ScrollBar`正是`通过监听滚动通知来实现`。通过NotificationListener监听滚动事件和通过ScrollController有两个主要的`不同`：

- 通过`NotificationListener`可以在从可滚动组件到`widget`树根之间任意位置都能监听。而`ScrollController`只能和具体的可滚动组件关联后才可以。

- 收到滚动事件后获得的信息不同；`NotificationListener`在收到滚动事件时，通知中会携带当前滚动位置和ViewPort的一些信息，而`ScrollController`只能获取当前滚动位置。

```dart
onNotification: (ScrollNotification notification) {
  double progress = notification.metrics.pixels/notification.metrics.maxScrollExtent;

  setState(() {
    _progress = "${(progress * 100).toInt()}%";
  });

  print("bottom edge: ${notification.metrics.extentAfter == 0}");

  return false;
}
```

在接收到滚动事件时，参数类型为`ScrollNotification`，它包括一个`metrics`属性，它的类型是`ScrollMetrics`，该属性包含当前`ViewPort`及滚动位置等信息：

- pixels：当前滚动位置。
- maxScrollExtent：最大可滚动长度。
- extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
- extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
- extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
- atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。

```dart

class _ScrollNotificationTestRouteState extends State<ScrollNotificationTestRoute> {

  String _progress = "0%"; // 保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('滚动监听'),),
      body: Scrollbar(child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels/notification.metrics.maxScrollExtent;

          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });

          print("bottom edge: ${notification.metrics.extentAfter == 0}");

          return false;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(itemBuilder: (context, index){
              return ListTile(title: Text("$index"),);
            }, itemCount: 100, itemExtent: 50,),
            CircleAvatar(radius: 30, child: Text(_progress),backgroundColor: Colors.black54,),
          ],
        ),
      ),),
    );
  }
}
```

![](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_scrolllistenerprogress.gif)
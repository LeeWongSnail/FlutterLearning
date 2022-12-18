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

每次滚动结束，可滚动组件都会讲位置offset存储到PageStorage中，当可滚动组件重新创建时，再恢复。也可以通过设置`ScrollController.keepScrollOffset`为`false`,则滚动位置将不会被存储

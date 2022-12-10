# ListView

ListView是最常用的可滚动组件之一，它可以沿一个方向线性排布所有子组件，并且它也支持列表项懒加载（在需要时才会创建）。

## 默认构造函数

```dart
ListView({
  ...  
  //可滚动widget公共参数
  Axis scrollDirection = Axis.vertical,
  bool reverse = false,
  ScrollController? controller,
  bool? primary,
  ScrollPhysics? physics,
  EdgeInsetsGeometry? padding,
  
  //ListView各个构造函数的共同参数  
  double? itemExtent,
  Widget? prototypeItem, //列表项原型，后面解释
  bool shrinkWrap = false,
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  double? cacheExtent, // 预渲染区域长度
    
  //子widget列表
  List<Widget> children = const <Widget>[],
})
```
- itemExtent: 这个值就是children的长度，这个长度是指滚动方向上子组件的长度，如果是垂直滚动就是长度，如果是水平方向就是宽度，在listView中指定itemExtent比让子组件自己决定自身长度有更好的性能。

- protoTypeItem 如果我们知道列表中的所有列表项长度都相同但不知道具体是多少，这时我们可以指定一个列表项，该列表项被称为 prototypeItem（列表项原型）。指定一个protoTypeItem就表示在lyout时会计算一次沿主轴方向的长度。

- shrinkWrap 该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false。



## ListView简单实用

```dart
class SingleChildScrollViewRoute extends StatelessWidget {
  const SingleChildScrollViewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.yellow,
      body: ListView(
        //是否根据子组件的总长度来设置ListView的长度
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: [
          Text('I hear your voice on the line' ,style: TextStyle(fontSize: 16),),
          Text('but it doesn’t stop the pain.',style: TextStyle(fontSize: 16)),
          Text('If I see you next to never',style: TextStyle(fontSize: 16)),
          Text('how can we say forever？',style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
```

这是一个比较简单的`ListView`的示例，我们设置了shrinkWrap，因为我们知道这个listView中的元素个数是已知的且不会超过设备的一个屏幕范围。

## ListView.builder

```dart
ListView.builder({
  // ListView公共参数已省略  
  ...
  required IndexedWidgetBuilder itemBuilder,
  int itemCount,
  ...
})
```

- itemBuilder 他是列表项的构造器，类型是`IndexedWidgetBuilder`,返回值是一个widget。当列表滚动到具体的index位置时，会调用该构建起构建列表项

- itemCount 列表项的数量，如果为null则为无限列表

```dart
class ListViewRouter extends StatelessWidget {
  const ListViewRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
      ),
      backgroundColor: Colors.yellow,
      body: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          }
      ),
    );;
  }
}
```

效果如下：

![flutterui_listview_normal](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_listview_normal.png)

##  ListView.separated

` ListView.separated`可以在生成的列表项之间添加一个分割组件，他比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。

```dart
class ListViewSeparateRoute extends StatelessWidget {
  const ListViewSeparateRoute({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(color: Colors.blue,);
    Widget divider2 = Divider(color: Colors.green,);
    return Scaffold(appBar: AppBar(title: Text('ListViewSpearate'),),
      body: ListView.separated(itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('$index'),);
      }, separatorBuilder: (BuildContext context, int index){
        return index % 2 == 0 ? divider1 : divider2;
      }, itemCount: 100),
    );
  }
}
```

![flutterui_listview_separate](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_listview_separate.png)

## 固定高度的列表

我们可以通过设置 itemExtent 或 prototypeItem 来指定列表项的高度，当然这种情况只适用于所有的列表项高度相同的情况

下面我们分别尝试使用这两种方法来设置列表项的高度:

### itemExtent

```dart
class FixHeightListViewRoute extends StatelessWidget {
  const FixHeightListViewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FixHeightListViewRoute'),),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return LayoutLogPrint(child: ListTile(title: Text('1111'),), tag: index,);
      },  itemExtent: 30,), 
    );
  }
}
```

![flutterui_listview_fixheight30](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_listview_fixheight30.png)

### prototypeItem

```dart
class FixHeightListViewRoute extends StatelessWidget {
  const FixHeightListViewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FixHeightListViewRoute'),),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return LayoutLogPrint(child: ListTile(title: Text('1111'),), tag: index,);
      },  prototypeItem: ListTile(title: Text('111'),),), 
    );
  }
}
```

![flutterui_listview_fixheight](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_listview_fixheight.png)

这里我们还是用了之前定义的LayoutLogPrint来打印子控件的约束

当我们设置`itemExtent `时，输出为:

```dart
flutter: 0: BoxConstraints(w=393.0, h=30.0)
flutter: 1: BoxConstraints(w=393.0, h=30.0)
flutter: 2: BoxConstraints(w=393.0, h=30.0)
flutter: 3: BoxConstraints(w=393.0, h=30.0)
```

当我们设置`prototypeItem`输出为:

```dart
flutter: 0: BoxConstraints(w=393.0, h=56.0)
flutter: 1: BoxConstraints(w=393.0, h=56.0)
flutter: 2: BoxConstraints(w=393.0, h=56.0)
flutter: 3: BoxConstraints(w=393.0, h=56.0)
flutter: 4: BoxConstraints(w=393.0, h=56.0)
```

## ListView 原理

`ListView` 内部组合了` Scrollable`、`Viewport` 和 `Sliver`，需要注意：

- ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
- 一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
- ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent ，则会使用 SliverFixedExtentList；如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，无论是是哪个，都实现了子组件的按需加载模型。

## 可加载更多的列表

```dart

class _InfiniteListViewState extends State<InfiniteListView> {
  // 标记是否到达了尾部
  static const loadingTag = "##loading##";
  // 要展示的文本
  var _words = <String>[loadingTag];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _retrieveData();
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) => {
      setState(() {
        _words.insertAll(_words.length - 1, generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('InfiniteListViewState'),),
      body: ListView.separated(itemBuilder: (BuildContext context, int index) {
        if (_words[index] == loadingTag) {
          // 如果到了最后一个
          if (_words.length < 100) {
            // 继续加载数据
            _retrieveData();
            return Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text('没有更多了', style: TextStyle(color: Colors.grey),),
            );
          }
        }
        return ListTile(title: Text(_words[index]),);
      }, separatorBuilder: (BuildContext context, int index) => Divider(height: .0,), itemCount: _words.length),
    );
  }
}
```

![flutterui_infinitelistview](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_infinitelistview.gif)
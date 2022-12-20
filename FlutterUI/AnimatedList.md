## AnimatedList

AnimatedList 可以在列表中插入或删除节点时执行一个动画，在需要添加或删除列表项的场景中会提高用户体验。

插入和删除的方法为

```dart
void insertItem(int index, { Duration duration = _kDuration });

void removeItem(int index, AnimatedListRemovedItemBuilder builder, { Duration duration = _kDuration }) ;
```

下面我们直接来看这段代码:

```dart

class _AnimatedListRouteState extends State<AnimatedListRoute> {

  var data = <String>[];

  int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for(var i = 0; i < counter; i++) {
      data.add('${i+1}');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('animate'),),
      body: Stack(
        children: [
          AnimatedList(itemBuilder: (BuildContext context, int index, Animation<double> animation){
            return FadeTransition(opacity: animation, child: buildItem(context, index),);
          }, key: globalKey, initialItemCount: data.length,),
          buildAddBtn(),
        ],
      ),
    );
  }

  Widget buildAddBtn() {
    return Positioned(child: FloatingActionButton(child: Icon(Icons.add), onPressed: () {
      data.add('${++counter}');
      globalKey.currentState!.insertItem(data.length - 1);
      print("添加 ${counter}");
    },), bottom: 30, left: 0, right: 0,);
  }

  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => onDelete(context, index),),
    );
  }

  void onDelete(context, index) {
      setState(() {
        globalKey.currentState!.removeItem(index, (context, animation) {
          var item = buildItem(context, index);
          print('删除 ${data[index]}');
          data.removeAt(index);
          return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(sizeFactor: animation,axisAlignment: 0.0,child: item,),);
        }, duration: Duration(milliseconds: 200));
      });
  }
}
```

我们这里使用data这个字符串数组来保存已有的数据，初始数据为['1','2','3','4','5']。同时我们创建了一个`GlobalKey`对象

这个key是跟AnimatedList的key绑定的，我们在操作数据时需要操作操作数据源data,操作列表动画key。例如

```dart
data.add('${++counter}');
globalKey.currentState!.insertItem(data.length - 1);
```

```dart
globalKey.currentState!.removeItem(index, (context, animation) {
    data.removeAt(index);
});
```

效果如下:

![flutterui_animatedList.gif](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_animatedList.gif)
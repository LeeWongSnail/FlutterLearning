# GridView

类似我们在iOS中使用的CollectionView,在collectionView中我们最主要的是看Layout,在flutter中也有一个对应的gridDelegate,用来设置布局。

gridDelegate的类型是SliverGridDelegate，这是一个抽象类，flutter中提供了两个子类，`SliverGridDelegateWithFixedCrossAxisCount`和`SliverGridDelegateWithMaxCrossAxisExtent`。

下面我们来介绍下：

## SliverGridDelegateWithFixedCrossAxisCount

```dart
SliverGridDelegateWithFixedCrossAxisCount({
  @required double crossAxisCount, 
  double mainAxisSpacing = 0.0,
  double crossAxisSpacing = 0.0,
  double childAspectRatio = 1.0,
})
```

- crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商。
- mainAxisSpacing：主轴方向的间距。
- crossAxisSpacing：横轴方向子元素的间距。
- childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。

再来看下示例代码:

```dart
class _GrideViewRouteState extends State<GrideViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
        body: GridView(children: [
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast,color: Colors.red,)
        ],gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 横轴展示的widget个数
          mainAxisSpacing: 20, //主轴方向的间距。
          childAspectRatio: 1.0, // 子元素在横轴长度和主轴长度的比例。
          crossAxisSpacing: 5, // 横轴方向子元素的间距。
        ),)
      );
  }
}
```

子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的,

![SliverGridDelegateWithFixedCrossAxisCount](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_%20SliverGridDelegateWithFixedCrossAxisCount.png)

## SliverGridDelegateWithMaxCrossAxisExtent

```dart
SliverGridDelegateWithMaxCrossAxisExtent({
  double maxCrossAxisExtent,
  double mainAxisSpacing = 0.0,
  double crossAxisSpacing = 0.0,
  double childAspectRatio = 1.0,
})
```

- maxCrossAxisExtent为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的，

```dart
class _SliverGridDelegateCrossAxisExtentState extends State<SliverGridDelegateCrossAxisExtent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
      body: GridView(padding: EdgeInsets.zero, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 80,
        childAspectRatio: 1.0
      ),
      children: [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
      ),);
  }
}
```

![SliverGridDelegateWithMaxCrossAxisExtent](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_%20SliverGridDelegateWithMaxCrossAxisExtent.png)


## GridView.count

这个跟上面提到的固定横轴个数的方法相同

```dart
class _SliverGridDelegateCrossAxisExtentState extends State<SliverGridDelegateCrossAxisExtent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
      body: GridView(padding: EdgeInsets.zero, gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 80,
        childAspectRatio: 1.0
      ),
      children: [
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
      ),);
  }
}
```

## GridView.extent

GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent

```dart
class _SliverGridDelegateCrossAxisExtentState extends State<SliverGridDelegateCrossAxisExtent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
      body: GridView.extent(
        maxCrossAxisExtent: 120.0,
        childAspectRatio: 2.0,
        children: <Widget>[
          Icon(Icons.ac_unit),
          Icon(Icons.airport_shuttle),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast),
        ],
      ),);
  }
}
```

## GridView.builder

GridView都需要一个widget数组作为其子元素，这些方式都会提前将所有子widget都构建好，所以只适用于子widget数量比较少时，当子widget比较多时，我们可以通过GridView.builder来动态创建子widget.

```dart

class InfiniteGridView extends StatefulWidget {
  const InfiniteGridView({Key? key}) : super(key: key);

  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {

  List<IconData> _icons = []; // 保存icon数据

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveIcons();
  }

  void _retrieveIcons() {
   Future.delayed(Duration(milliseconds: 200)).then((e){
     setState(() {
       _icons.addAll([
         Icons.ac_unit,
         Icons.airport_shuttle,
         Icons.all_inclusive,
         Icons.beach_access,
         Icons.cake,
         Icons.free_breakfast,
       ]);
     });
   }) ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('GridView'),),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 每行三列
        childAspectRatio: 1.0 // 宽高比
      ), itemBuilder: (context, index) {
        if(index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      }, itemCount: _icons.length,),
    );
  }
}
```

![gridview](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_gridview.gif)
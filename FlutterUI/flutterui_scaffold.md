# Scaffold 

`Material` 组件库提供了丰富多样的组件，本节介绍一下最常用的 `Scaffold` 组件，其余的读者可以自行查看文档或 `Flutter Gallery` 中 `Material` 组件部分的示例。

Scaffold是Flutter给我们提供的一个完整的页面结构，包含导航栏抽屉菜单以及底部tab等，

下面我们直接先看这段代码:

```dart
class _ScaffoldRouteState extends State<ScaffoldRoute>  with SingleTickerProviderStateMixin{

int _selectIndex = 1;
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Scaffold'),
      actions: [
        IconButton(onPressed: () {
        }, icon: Icon(Icons.share)),
      ],
      leading: Builder(builder: (context) {
        return IconButton(onPressed: () {
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.dashboard, color: Colors.white,));
      },),
      backgroundColor: Colors.yellow,
    ),
    drawer: CustomDrawer(),
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.air), label: 'Air'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Music')
      ],
      currentIndex: _selectIndex,
      // fixedColor: Colors.blue,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: _onAdd,
    ),
  );
}
```

![flutterui_scaffold](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_scaffold.png)

## AppBar

导航栏组件

```dart
AppBar({
  Key? key,
  this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
  this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
  this.title,// 页面标题
  this.actions, // 导航栏右侧菜单
  this.bottom, // 导航栏底部菜单，通常为Tab按钮组
  this.elevation = 4.0, // 导航栏阴影
  this.centerTitle, //标题是否居中 
  this.backgroundColor,
  ...   //其他属性见源码注释
})
```

我们主要看下上面几个属性，在上面的例子中，我们设置了

```dart
appBar: AppBar(
  title: Text('Scaffold'),
  actions: [
    IconButton(onPressed: () {
    }, icon: Icon(Icons.share)),
  ],
  leading: Builder(builder: (context) {
    return IconButton(onPressed: () {
      Scaffold.of(context).openDrawer();
    }, icon: Icon(Icons.dashboard, color: Colors.white,));
  },),
  backgroundColor: Colors.yellow,
),
```

## Drawer

Scaffold的drawer和endDrawer属性可以分别接受一个Widget来作为页面的左、右抽屉菜单。因此实际上我们可以随便写一个作为抽屉视图的widget

```dart
drawer: Container(
  width: 300,
  height: 500,
  color: Colors.yellow,
),
```

![flutterui_drawer](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_drawer.png)

下面我们尝试来自定义一个widget来实现抽屉效果

```dart

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(context: context, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 38), child:  Row(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: ClipOval(
                child: Image.asset('images/icon.webp', width: 80,),
              ),),
              Text('LeeWong', style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
          ),
          Expanded(child: ListView(children: [
            ListTile(leading: Icon(Icons.add), title: Text('Add Account'),),
            ListTile(leading: Icon(Icons.settings), title: Text('Manager Account'),),
          ],))
        ],
      ),
      ),
    );
  }
}
```

效果如下:

![flutterui_customdrawer](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_customdrawer.png)

这里使用到了Drawer以及MediaQuery.removePadding 我们先不用太了解知道这个组件可以自定义就可以了

## FloatingActionButton

`FloatingActionButton`是`Material`设计规范中的一种特殊`Button`，通常悬浮在页面的某一个位置作为某种常用动作的快捷入口，如本节示例中页面右下角的"➕"号按钮。我们可以通过`Scaffold`的`floatingActionButton`属性来设置一个`FloatingActionButton`，同时通过`floatingActionButtonLocation`属性来指定其在页面中悬浮的位置.


## tab

```dart
bottomNavigationBar: BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.air), label: 'Air'),
    BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
    BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Music')
  ],
  currentIndex: _selectIndex,
  // fixedColor: Colors.blue,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
  onTap: _onItemTapped,
),
```

我们这里使用的是`BottomNavigationBar`。



# 颜色和主题

## 如何将颜色字符串转成 Color 对象

```dart
Color(0xffdc380d); //如果颜色固定可以直接使用整数值
//颜色是一个字符串变量
var c = "dc380d";
Color(int.parse(c,radix:16)|0xFF000000) //通过位运算符将Alpha设置为FF
Color(int.parse(c,radix:16)).withAlpha(255)  //通过方法将Alpha设置为FF
```

## 颜色亮度

我们要实现一个背景颜色和Title可以自定义的导航栏，并且背景色为深色时我们应该让Title显示为浅色；背景色为浅色时，Title 显示为深色。

首先我们知道Color有一个computeLuminance()方法可以返回一个0-1的值数字越大表示颜色越深，因此我们可以根据这个来判断深色和浅色

```dart

class NavBarRoute extends StatelessWidget {
  const NavBarRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NavBar(color: Colors.blue, title: "白色"),
          NavBar(color: Colors.black, title: "黑色")
        ],
      ),
    );
  }
}


class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.color, required this.title}) : super(key: key);

  final String title;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [BoxShadow(color: Colors.black26, offset:  Offset(0, 3), blurRadius: 3)],),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black),),
      alignment: Alignment.center,
    );
  }
}
```
效果如下:

![flutterui_navbar](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_navbar.png)

## MaterialColor

MaterialColor是实现Material Design中的颜色的类，它包含一种颜色的10个级别的渐变色。

我们可以根据 shadeXX 来获取具体索引的颜色。Colors.blue.shade50到Colors.blue.shade900的色值从浅蓝到深蓝渐变

![flutterui_materialcolor](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_materialcolor.jpeg)

## 主题

Theme组件可以为Material APP定义主题数据（ThemeData）。Material组件库里很多组件都使用了主题数据，如导航栏颜色、标题字体、Icon样式等。Theme内会使用InheritedWidget来为其子树共享样式数据。

### ThemeData

ThemeData用于保存是Material 组件库的主题数据，Material组件需要遵守相应的设计规范，而这些规范可自定义部分都定义在ThemeData中了，所以我们可以通过ThemeData来自定义应用主题。在子组件中，我们可以通过Theme.of方法来获取当前的ThemeData。

### 示例

```dart

class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  var _themeColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色跟随主题")
                ]
            ),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(
                    color: Colors.black
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色")
                  ]
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>  //切换主题
            setState(() =>
            _themeColor =
            _themeColor == Colors.teal ? Colors.blue : Colors.teal
            ),
            child: Icon(Icons.palette)
        ),
      ),
    );
  }
}
```
效果如下:

![flutterui_theme_blue](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_theme_blue)

![flutterui_theme_teal](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_theme_teal.png)

注意:

可以通过局部主题覆盖全局主题，正如代码中通过 Theme 为第二行图标指定固定颜色（黑色）一样，这是一种常用的技巧，Flutter 中会经常使用这种方法来自定义子树主题。那么为什么局部主题可以覆盖全局主题？这主要是因为 widget 中使用主题样式时是通过Theme.of(BuildContext context)来获取的，我们看看其简化后的代码：

```dart
static ThemeData of(BuildContext context, { bool shadowThemeOnly = false }) {
   // 简化代码，并非源码  
   return context.dependOnInheritedWidgetOfExactType<_InheritedTheme>().theme.data
}
```
context.dependOnInheritedWidgetOfExactType 会在 widget 树中从当前位置向上查找第一个类型为_InheritedTheme的 widget。所以当局部指定Theme后，其子树中通过Theme.of()向上查找到的第一个_InheritedTheme便是我们指定的Theme。

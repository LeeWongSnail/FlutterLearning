# DecoratedBox&BoxDecoration

DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。

我们直接来看代码实现

```dart
Widget build(BuildContext context) {
  return Center(
    child: DecoratedBox(
      decoration: BoxDecoration(
        // 背景渐变
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
        // 3像素圆角
        borderRadius: BorderRadius.circular(10.0),
        shape: BoxShape.rectangle,
        backgroundBlendMode: BlendMode.darken,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
        child: Text('Login', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
```

展示效果为:

![flutterui_decorationbox]()

## DecorationBox

这是一个UI控件，配合BoxDecoration来使用，我们来看下他的属性

- decoration 一般我们都是使用BoxDecoration 
- position 确定设置的是前景的效果还是背景的效果 有background何foreground两个选项

## BoxDecoration

我们先看下这个类中的属性

```dart
BoxDecoration({
  Color color, //颜色
  DecorationImage image,//图片
  BoxBorder border, //边框
  BorderRadiusGeometry borderRadius, //圆角
  List<BoxShadow> boxShadow, //阴影,可以指定多个
  Gradient gradient, //渐变
  BlendMode backgroundBlendMode, //背景混合模式
  BoxShape shape = BoxShape.rectangle, //形状
})
```

- shape 这里有两个选项 rectangle矩形 circle圆形 注意如果设置为circle 不能设置圆角


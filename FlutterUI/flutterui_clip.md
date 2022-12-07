# Clip

clip主要作用是对子控件进行裁剪，主要有一下几种形式

![flutterui_clip](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_clip.png)

## ClipOval

子组件为正方形时剪裁成内贴圆形；为矩形时，剪裁成内贴椭圆

```dart
 ClipOval(child: Container(
  width: 120,
  height: 120,
  color: Colors.red,
),),
ClipOval(child: Container(
  width: 120,
  height: 80,
  color: Colors.red,
),),
```

![flutterui_clip_ClipOval](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_clip_ClipOval.png)

## ClipRRect

将子组件剪裁为圆角矩形


```dart
ClipRRect(borderRadius: BorderRadius.circular(20), child: Container(
  width: 120,
  height: 80,
  color: Colors.red,
),),
```

![flutterui_clip_cliprrect](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_clip_cliprrect.png)

## ClipRect

默认剪裁掉子组件布局空间之外的绘制内容（溢出部分剪裁）

```dart
ClipRect(child: Container(
  width: 120,
  height: 60,
  color: Colors.red,
  child: Text('Hello World', style: TextStyle(fontSize: 40),),
),),
```

![flutterui_clip_cliprect](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_clip_cliprect.png)

## ClipPath

按照自定义的路径剪裁


```dart
ClipPath.shape(shape: StadiumBorder(), child: Container(
  height: 150,
  width: 250,
  color: Colors.red,
  child: FlutterLogo(),
)),
ClipPath(clipper: _TrianglePath(),child: Container(
  width: 250,
  height: 150,
  color: Colors.red,
  child: FlutterLogo(),
),),


class _TrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
```

![flutterui_clip_custom](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_clip_custom.png)

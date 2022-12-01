## Icon

Flutter 中，可以像Web开发一样使用 iconfont，iconfont 即“字体图标”，它是将图标做成字体文件，然后通过指定不同的字符而显示不同的图片。

在Flutter开发中，iconfont和图片相比有如下优势：

- 体积小：可以减小安装包大小。
- 矢量的：iconfont都是矢量图标，放大不会影响其清晰度。
- 可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等。
- 可以通过TextSpan和文本混用。

## 配置字体图标

如果要使用字体图片需要先添加配置，在pubspec.yaml

```yaml
flutter:
  uses-material-design: true
```

## 测试使用

```dart
Text('\uE03e', style: TextStyle(
	fontFamily: 'MaterialIcoons',
	fontSize: 24,
	color: Colors.red
),),
```

## IconData

鉴于上面这种方式使用起来并不直观，所以flutter定义了IconData和Icon来专门显示字体图标。

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Icon(Icons.accessible,color: Colors.green),
    Icon(Icons.error,color: Colors.green),
    Icon(Icons.fingerprint,color: Colors.green),
  ],
)
```

## 使用自定义字体

### 字体图标文件导入

同样需要在pubspec.yaml文件中配置

```yaml
fonts:
  - family: myIcon  #指定一个字体名
    fonts:
      - asset: fonts/iconfont.ttf
```

为了使用起来更方便，我们可以参考Flutter中IconData提供的方法，
在使用自定义字体图标时更简单。

```dart
class MyIcons{
  // book 图标
  static const IconData book = const IconData(
      0xe614, 
      fontFamily: 'myIcon', 
      matchTextDirection: true
  );
  // 微信图标
  static const IconData wechat = const IconData(
      0xec7d,  
      fontFamily: 'myIcon', 
      matchTextDirection: true
  );
}
```

这样我们在使用时就可以简单的使用了:

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Icon(MyIcons.book,color: Colors.purple),
    Icon(MyIcons.wechat,color: Colors.green),
  ],
)
```

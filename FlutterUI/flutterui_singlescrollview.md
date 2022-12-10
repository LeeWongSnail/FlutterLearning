# SingleChildScrollView

SingleChildScrollView只能接受一个子组件

```dart
SingleChildScrollView({
  this.scrollDirection = Axis.vertical, //滚动方向，默认是垂直方向
  this.reverse = false, 
  this.padding, 
  bool primary, 
  this.physics, 
  this.controller,
  this.child,
})
```
这里重点说下`primary`属性:它表示是否使用widget树中默认的`PrimaryScrollController`;当滑动方向为垂直方向并且没有指定controller时，primary默认为true。

通常`SingleChildScrollView`只应在期望的`内容不会超过屏幕太多`时使用，这是因为`SingleChildScrollView`不支持基于` Sliver `的延迟加载模型，所以如果预计视口可能包含`超出屏幕尺寸太多`的内容`时`，那么使用`SingleChildScrollView将会非常昂贵`（性能差）.

```dart
@override
Widget build(BuildContext context) {
  String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return Scrollbar(child: SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(children: str.split('').map((e) => Text(e, textScaleFactor: 2,)).toList(),),
  ));
}
```

![flutterui_singlechildscrollview](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_singlescrollview.gif)

# 进度条

## LinearProgressIndicator

线性，条状的进度条

```dart
LinearProgressIndicator(value: null, backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
```

- value 表示当前进度 范围是0-1，如果是null则会变成一个循环的动画
- backgroundColor 背景颜色 从0-1范围内的颜色
- valueColor 指示器进度条颜色；类型是Animation<Color> 这里我们一般使用AlwaysStoppedAnimation。

## CircularProgressIndicator

圆形进度条

```dart
CircularProgressIndicator(value: null, backgroundColor: Colors.blue, valueColor: AlwaysStoppedAnimation(Colors.grey),strokeWidth: 10,),
```

常见的设置项仍然是上面三个，不过这里可以通过`strokeWidth`设置线的宽度

## 自定义尺寸

上面讲过的两种进度都是默认的宽高，实际上我们可以通过ConstrainedBox和SizeBox来指定尺寸

```dart
SizedBox(
  height: 50,
  child:LinearProgressIndicator(value: null, backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
),
SizedBox(
  width: 200,
  height: 200,
  child: CircularProgressIndicator(value: null, backgroundColor: Colors.blue, valueColor: AlwaysStoppedAnimation(Colors.grey),strokeWidth: 10,),
)
```
通过给sizeBox设置宽高来约束进度条的尺寸

## 进度色动画

我们通过下面这个方式来做一个5s内进度从0-1的动画进度条

添加动画控制器，并设置控制器的信息

```dart

late AnimationController _animationController;

@override
void initState() {
  _animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
  _animationController.forward();
  _animationController.addListener(() => setState(() => {}));
  // TODO: implement initState
  super.initState();
}
```

添加进度条视图

```dart
@override
Widget build(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(top: 100),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(20),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue).animate(_animationController),
              value: _animationController.value,
            ),
          ),
        ],
      ),
    ),
  );

}
```

注意这里将进度条的value设置成了动画控制器的value,这样value就是一个变化的值

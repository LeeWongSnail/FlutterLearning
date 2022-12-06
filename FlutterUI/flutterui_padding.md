# Padding

我们先来看下代码

```dart
 @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(left: 20), child: Text('EdgeInsets.only(left: 20)', style: TextStyle(fontSize: 14),),),
          Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text('EdgeInsets.symmetric(vertical: 10)', style: TextStyle(fontSize: 14)),),
          Padding(padding: EdgeInsets.fromLTRB(150, 0, 20, 0),child: Text('EdgeInsets.fromLTRB(20, 0, 20, 0)', style: TextStyle(fontSize: 14)),)
        ],
      ),
    );
  }
```

Padding这个控件主要是用来设置子控件的上下左右间距。其主要的一个属性是padding,这个padding我们最常用的是EdgeInsets类型。设置方法主要有一下几种

- fromLTRB(double left, double top, double right, double bottom)：分别指定四个方向的填充。
- all(double value) : 所有方向均使用相同数值的填充。
- only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)。
- symmetric({ vertical, horizontal })：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right。

下面是上述代码执行效果:

![flutterui_padding]()
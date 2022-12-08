# 空间适配（FittedBox）

我们先来看下这段代码，向下会发生什么

```dart
Padding(
  padding: const EdgeInsets.symmetric(vertical: 30.0),
  child: Row(children: [Text('xx'*30)]), //文本长度超出 Row 的最大宽度会溢出
),
```
因为在这段代码中我们使用了row所以我们的Text需要在一行内展示，但是很明显文本的个数已经超出了一个屏幕所能展示的范围，因此，会直接溢出的提示。

![flutterui_fit_overflow)](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_fit_overflow.png)

当然如果我们的初衷只是希望文本在超出一行之后可以自动换行，我们可以直接使用Text不用row去包裹就可以了。

```dart
FittedBox(
  child: Row(children: [Text('xx'*30)]),
  // fit: BoxFit.scaleDown,
  // clipBehavior: Clip.none,
),
```

![flutterui_fit_newlin](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_fit_newline.png)

但是如果我们是希望，文本内容可以在一行内展示，不换行，那我们只能使用类似swift中的`adjustsFontSizeToFitWidth`属性，让文本字体大小随着文本内容的增多而变小。这样才可以完整的展示所有文本内容。

上面这两个问题的本质就是： `子组件如何适配父组件空间`。而根据 Flutter 布局协议适配算法应该在容器或布局组件的 layout 中实现，为了方便开发者自定义适配规则，Flutter 提供了一个 FittedBox 组件

适配原理:

- FittedBox 在布局子组件时会忽略其父组件传递的约束，可以允许子组件无限大，即FittedBox 传递给子组件的约束为（0<=width<=double.infinity, 0<= height <=double.infinity）。
- FittedBox 对子组件布局结束后就可以获得子组件真实的大小。
- FittedBox 知道子组件的真实大小也知道他父组件的约束，那么FittedBox 就可以通过指定的适配方式（BoxFit 枚举中指定），让起子组件在 FittedBox 父组件的约束范围内按照指定的方式显示。

## fit

```dart
Container(
  width: 50,
  height: 50,
  color: Colors.red,
  child: FittedBox(fit: BoxFit.none, child: Container(width: 60,height: 70, color: Colors.blue,),),
   ),
   Text('Hello World'),
   Padding(padding: EdgeInsets.symmetric(vertical: 10)),
   Container(
     width: 50,
     height: 50,
     color: Colors.red,
     child: FittedBox(fit: BoxFit.contain, child: Container(width: 60,height: 70, color: Colors.blue,),),
          ),
Text('Hello World'),
```
我们直接来看上面这段代码,第一个FitterBox和第二个FittedBox的区别就在与fit属性的设置

![flutterui_fit_none](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_fit_none.png)

- fit: none 表示子组件可以无限大不受父组件的约束，所以子组件60*70>50*50 所以我们只看到蓝色看不到红色
- fit: none 子组件超出父组件 默认也不会被裁减而是会覆盖到同级组件上，这里覆盖到了Text组件上
- fit: contain 表示包含，即子组件必须小于父组件大小，但是子组件要保持原有的比例， 所以自建就编程了 x*50,其中x<50，所以这里我们可以看到一部分红色的背景

## 单行缩放布局

我们这里来向下我们一开始单行文本在一行内展示

```dart
Center(
  child: Column(
    children:  [
      wRow(' 90000000000000000 '),
      FittedBox(child: wRow(' 90000000000000000 ')),
      wRow(' 800 '),
      FittedBox(child: wRow(' 800 ')),
    ]
        .map((e) => Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: e,
    ))
        .toList(),
  ),
),

  // 直接使用Row
Widget wRow(String text) {
  Widget child = Text(text);
  child = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [child, child, child],
  );
  return child;
}
```

![flutterui_fit_textinline](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_fit_textinline.png)

因为我们给Row在主轴的对齐方式指定为MainAxisAlignment.spaceEvenly，这会将水平方向的的剩余显示空间均分成多份穿插在每一个 child之间。

首先第一行内容直接溢出这是我们所预想到的，第二行我们添加了fitBox后内容自动缩小展示完全，也是我们想到的，但是当文本的内容比较少的时候我们发现添加了fitBox反而有副作用，这是什么原因呢？

原因其实很简单：在指定主轴对齐方式为 spaceEvenly 的情况下，Row 在进行布局时会拿到父组件的约束，如果约束的 maxWidth 不是无限大，则 Row 会根据子组件的数量和它们的大小在主轴方向来根据 spaceEvenly 填充算法来分割水平方向的长度，最终Row 的宽度为 maxWidth；但如果 maxWidth 为无限大时，就无法在进行分割了，所以此时 Row 就会将子组件的宽度之和作为自己的宽度。

即在内容不满一行时，maxWidth默认是所有子控件的宽度之和

因此我们如果想要达到我们想要的效果，我们需要制定，组件的最小宽度为屏幕宽度，避免像上面一样发生子组件拥挤

```dart
Padding(padding: EdgeInsets.symmetric(vertical: 10)),
wRow(' 90000000000000000 '),
SingleLineFittedBox(child: wRow(' 90000000000000000 ')),
wRow(' 800 '),
SingleLineFittedBox(child: wRow(' 800 ')),
```
![flutterui_fit_inlinetext](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_fit_inlinetext.png)


我们将最小宽度（minWidth）约束指定为屏幕宽度，因为Row必须得遵守父组件的约束，所以 Row 的宽度至少等于屏幕宽度，所以就不会出现缩在一起的情况；同时我们将 maxWidth 指定为无限大，则就可以处理数字总长度超出屏幕宽度的情况。



![flutterui_fittedBox.png](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_fittedBox.png)
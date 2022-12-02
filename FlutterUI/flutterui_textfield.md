#输入框 TextField

![flutterui_textfield](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_textfield.png)

```dart
TextField(autofocus: true,decoration: InputDecoration(
  labelText: '请输入用户名',
  hintText: '用户名或者邮箱',
  prefix: Icon(Icons.person),
),onChanged: (value){
  print(value);
},),
```

上述是一个简单的文本框，下面我们来介绍下输入框的一些属性：

## 基础属性
- labelText 提示文案 提示这个输入框要输入的文案内容
- hintText 占位文案，一旦有文案输入会自动消失
- prefix 输入框左边的icon
- onChanged 文本输入框内容变化回调

## controller 

编辑框控制器，可以通过他来监听编辑框的一些事件，例如获取编辑框内容，选择编辑框内容，监听文本改变事件。

```dart
  // 控制器
 TextEditingController _unnamedController = TextEditingController();

// 监听文本变化
_unnamedController.addListener(() {
  //获取文本框内容
  print(_unnamedController.text);
});

// 设置文本框默认值
_unnamedController.text = 'LeeWong';

// 设置文本框选中范围
_unnamedController.selection = TextSelection(baseOffset: 2, extentOffset: _unnamedController.text.length);

```
设置方法:

```dart
TextField(autofocus: false,decoration: 		                   InputDecoration(
  labelText: '请输入密码',
  hintText: '输入密码包含字母和数字',
  prefix: Icon(Icons.password)
),controller: _unnamedController,),
```

##  focusNode 用于控制TextField是否占有当前键盘的焦点，

```dart
// 声明一个focusNode
FocusNode _emailFocusNode = FocusNode();

// 与TextField关联
TextField(focusNode: _emailFocusNode,),

// 让对应的文本框放弃焦点
_emailFocusNode.unfocus();

// 获取当前文本框是否有焦点
_emailFocusNode.hasFocus;
```

如果需要让一个文本框自动获取焦点，我们需要

```dart
// 声明一个焦点范围节点
FocusScopeNode? focusScopeNode;

// 获取到当前获取焦点的文本框来初始化范围节点
focusScopeNode = FocusScope.of(context);

// 某个文本框请求获取焦点
focusScopeNode.requestFocus(_emailFocusNode);

```

## inputDecoration 用于控制TextField的外观展示，文本，背景框，边框等。

```dart
TextField(autofocus: true,decoration: InputDecoration(
	// labelText: '请输入用户名',
	hintText: '用户名或者邮箱',
	prefix: Icon(Icons.person),
	// fillColor: Colors.red,
	// filled: true,
	enabledBorder: UnderlineInputBorder(borderSide: 		BorderSide(color: Colors.red)),
 	focusedBorder: UnderlineInputBorder(
   		borderSide: BorderSide(color: Colors.green),
  ),
),onChanged: (value){
  print(value);
},focusNode: _emailFocusNode,),
```
上述
- enabledBorder 表示输入框获取焦点时下划线
- focusedBorder 表示失去焦点时下划线
- fillColor 为输入框背景颜色 需配合filled使用
- filled 为背景颜色是否填充

## keyboardType

设置该输入框默认的键盘输入类型:

- text	文本输入键盘
- multiline	多行文本，需和maxLines配合使用(设为null或大于1)
- number	数字；会弹出数字键盘
- phone	优化后的电话号码输入键盘；会弹出数字键盘并显示“* #”
- datetime	优化后的日期输入键盘；Android上会显示“: -”
- emailAddress	优化后的电子邮件地址；会显示“@ .”
- url	优化后的url输入键盘； 会显示“/ .”

## textInputAction

键盘回车位按钮图标

- unspecified 展示return
- done 展示done 完成
- go 
- search 搜索
- send 发送
- next 下一步
- previous 上一步
- continueAction继续
- join
- route
- emergencyCall
- newline 换行

## style 

设置编辑框内的文本样式 是 TextStyle类型

例如:

```dart
TextField(autofocus: false,decoration: InputDecoration(
   labelText: '请输入密码',
   hintText: '输入密码包含字母和数字',
   prefix: Icon(Icons.password)
 ),controller: _unnamedController,style: TextStyle(color: Colors.red, fontSize: 20),),
```

## textAlign

文本的对齐方式,为 TextAlign类型

```dart
textAlign: TextAlign.right
```

## autofocus

是否自动获取焦点,bool类型

```dart
autofocus: false
```

## obscureText 

是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换, bool类型

```dart
obscureText: true
```

## maxLines

输入框的最大行数，默认为1；如果为null，则无行数限制

```dart
maxLines: 5
```
默认会改变输入框的高度，使用时需要注意，如果不设置默认是当行向右扩展移动。

## maxLength& maxLengthEnforcement

- maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。

- maxLengthEnforcement决定当输入文本长度超过maxLength时如何处理，如截断、超出等。

```dart
TextField(autofocus: false,maxLength: 10, maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,decoration: InputDecoration(
  labelText: '请输入密码',
  hintText: '输入密码包含字母和数字',
  prefix: Icon(Icons.password)
),controller: _unnamedController,textAlign: TextAlign.right),
```
![flutterui_max](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_max.png)

## toolbarOptions

长按或鼠标右击时出现的菜单，包括 copy、cut、paste 以及 selectAll。

```dart
toolbarOptions: ToolbarOptions(copy: true, cut: true, paste: true)
```
如果希望哪一个展示就直接设置为TRUE就可以。

## onChange

输入框内容改变时的回调函数，与controller效果类似

```dart
TextField(autofocus: true,decoration: InputDecoration(
  hintText: '用户名或者邮箱',
),onChanged: (value){
  print(value);
},),
```

## onEditingComplete&onSubmitted

这两个回调都是在输入框输入完成时触发，比如按了键盘的完成键（对号图标）或搜索键（🔍图标
)

不同的是两个回调签名不同: 

- onSubmitted回调是ValueChanged<String>类型，它接收当前输入内容做为参数，

- onEditingComplete不接收参数

## inputFormatters

用于指定输入格式，在输入内容改变时会进行校验

```dart
inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-z]'))
]
```
这种情况下我们的输入框就不允许输入非小写a-z字母之外的其他值

## enable

输入框是否可用，如果为false则表示被禁用，禁用状态下不接受输入和事件。同时显示禁用样式。

## cursorWidth& cursorRadius& cursorColor

自定义输入光标的宽度圆角和颜色

```dart
cursorColor: Colors.green, cursorWidth: 6, cursorRadius: Radius.circular(3)
```

`注意`: 这里cursorRadius是Radius类型的。

![flutterui_cursor](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_cursor.png)
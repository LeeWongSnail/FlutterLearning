# 开关Switch

flutter为我们封装好了一个开关控件并提供了开关控件状态变化之后的回调方法。

```dart

bool _switchSelected = true; // 维护单选开关的状态

Switch(value: _switchSelected, onChanged: (value){
  setState(() {
    _switchSelected = value;
  });
}),
```

我们先声明了一个bool类型的变量用来保存道歉Switch的状态，并在开关状态改变时调用setState方法修改它。

Switch有一个activeColor属性，我们可以设置被选中时高亮的颜色。

`注意`:

目前switch没有改变宽高的方法

# 复选框 CheckBox

```dart
bool _checkboxSelected = true; // 维护复选框的状态

Checkbox(value: _checkboxSelected, onChanged: (value){
  setState(() {
    _checkboxSelected = value!;
  });
}, activeColor: Colors.red,),
```
跟switch相同我们也声明了一个bool类型的变量来记录复选框的状态。

`注意`:

目前CheckBox没有改变宽高的方法

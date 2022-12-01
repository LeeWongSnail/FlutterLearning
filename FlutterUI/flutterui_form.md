# Form

表单，即我们有一组要提交的数据。在正式提交之前我们可能需要校验他们的合法性，但是对每一个输入都进行校验会非常麻烦，而且如果用户想要清除一组textField的内容除了一个个清除是否还有什么好的方法呢？

flutter提供了一个form组件。对输入框进行分组。然后统一操作，如输入内容校验，输入框重置，以及输入内容保存。

![flutterui_form]()

## Form

```dart
Form({
  required Widget child,
  bool autovalidate = false,
  WillPopCallback onWillPop,
  VoidCallback onChanged,
})
```

- autovalidate：是否自动校验输入内容；当为true时，每一个子 FormField 内容发生变化时都会自动校验合法性，并直接显示错误信息。否则，需要通过调用FormState.validate()来手动校验。

- onWillPop：决定Form所在的路由是否可以直接返回（如点击返回按钮），该回调返回一个Future对象，如果 Future 的最终结果是false，则当前路由不会返回；如果为true，则会返回到上一个路由。此属性通常用于拦截返回按钮。

- onChanged：Form的任意一个子FormField内容发生变化时会触发此回调。

## FormField

Form的子孙元素必须是FormField类型，FormField是一个抽象类，定义几个属性，FormState内部通过它们来完成操作，FormField部分定义如下

```dart
const FormField({
  ...
  FormFieldSetter<T> onSaved, //保存回调
  FormFieldValidator<T>  validator, //验证回调
  T initialValue, //初始值
  bool autovalidate = false, //是否自动校验。
})
```

这里我们一般使用系统提供的TextFormField类就可以了。

## FormState

FormState为Form的State类，可以通过Form.of()或GlobalKey获得。我们可以通过它来对Form的子孙FormField进行统一操作。

- FormState.validate()：调用此方法后，会调用Form子孙FormField的validate回调，如果有一个校验失败，则返回false，所有校验失败项都会返回用户返回的错误提示。

- FormState.save()：调用此方法后，会调用Form子孙FormField的save回调，用于保存表单内容

- FormState.reset()：调用此方法后，会将子孙FormField的内容清空。

## 示例

```dart
body: Form(
        // 设置globalKey 用于后面获取formState
        key: _formKey,
        // 用户交互时才进行校验
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autofocus: false,
              controller: _unamedController,
              decoration: InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  icon: Icon(Icons.person)
              ),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : '用户名不能为空';
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入您的登录密码',
                  icon: Icon(Icons.password)
              ),
              validator: (v){
                return v!.trim().length > 5 ? null : '密码不能小于6位';
              },
            ),
            Padding(padding: EdgeInsets.only(top: 28),
              child: Row(
                children: [
                  Expanded(child: ElevatedButton(child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('登录'),
                  ),
                    onPressed: () {
                      // 通过_formKey.currentState获取FormState
                      // 调用validate方法校验用户名和密码是否合法
                      // 校验通过后在提交数
                      if ((_formKey.currentState as FormState).validate()) {
                        // 验证通过提交数据
                      }
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
```

我们重点看下diamante中TextFormField中的

- validator 可以用来自定义每个输入字段的校验规则

- 如何根据formKey获取state 然后进行校验


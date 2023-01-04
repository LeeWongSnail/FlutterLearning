# InheritedWidget(数据共享)

`InheritedWidget`提供了一种在 `widget` 树中从上到下共享数据的方式，比如我们在应用的根` widget` 中通过`InheritedWidget`共享了一个数据，那么我们便可以在任意子`widget` 中来获取该共享的数据！


下面我们通过这个例子来讲解：

```dart

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inherited'),),
      body: Center(
        child: ShareDataWidget( //使用ShareDataWidget
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _TestWidget(),//子widget中依赖ShareDataWidget
              ),
              ElevatedButton(
                child: Text("Increment"),
                //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                onPressed: () => setState(() => ++count),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}
```

示例效果如下

![flutterui_ InheritedWidget]()

解析：
这个示例中我们页面中存在一个按钮和一个文本展示，每次点击按钮都会将文本中的数字加1，数字的值保存在data属性中，展示值和按钮的组件在InheritedWidgetTestRoute中。

首先我们看下共享数据保存ShareDataWidget

```dart
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}
```

- 需要继承自InheritedWidget

- 定义了一个data属性用来存放计数值

- 定义了一个of(BuildContext context)方法用来便捷获取当前对象

- updateShouldNotify 决定当data发生改变时是否需要通知依赖data的子组件 重新build

下面我们在来看下展示个数的子组件

```dart
class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString());
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}
```

- build方法中添加了我们对ShareDataWidget的依赖
- didChangeDependencies 组件的依赖是否发生了改变

下面我们主要介绍didChangeDependencies这个方法：

之前介绍`StatefulWidget`时，我们提到`State`对象有一个`didChangeDependencies`回调，它会在`“依赖”`发生变化时被Flutter 框架调用。

而这个`“依赖”`指的就是`子widget` 是否使用了`父widget` 中`InheritedWidget`的数据！

如果使用了，则代表子 widget 有依赖；
如果没有使用则代表没有依赖。

这种机制可以使子组件在所依赖的`InheritedWidget`变化时来更新自身！

比如当`主题`、`locale(语言)`等发生变化时，依赖其的子 widget 的didChangeDependencies方法将会被调用。

上面的代码，每次我们点击按钮计数就会加1，控制台会输出：

```
flutter: Dependencies change
```

按照上面我们分析的，如果我们把`__TestWidgetState`中的代码改为:

```dart
class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    // return Text(ShareDataWidget.of(context)!.data.toString());
    return Text('count')
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}
```
这样的话就不依赖ShareDataWidget的数据，这时候didChangeDependencies就不会被调用。

## 深入理解InheritedWidget

如果我们的子控件希望可以实时获取到点击数，但是有不希望每次都要调用didChangeDependencies那么我们应该怎么处理呢？

先说结果，如果我们不想被通知，那么我们首先想到的是解除依赖关系：

```dart
  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>()?.widget as ShareDataWidget ;
  }
```
修改`of(BuildContext context)`方法如上，这时候我们在运行程序就会发现，didChangeDependencies方法不会每次都调用，而且我们的点击次数计数也是正确的。

下面我们来看下这两个方法的区别


```dart
  @override
  InheritedElement? getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    final InheritedElement? ancestor = _inheritedWidgets == null ? null : _inheritedWidgets![T];
    return ancestor;
  }
```

```dart
  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({Object? aspect}) {
    assert(_debugCheckStateIsActiveForAncestorLookup());
    final InheritedElement? ancestor = _inheritedWidgets == null ? null : _inheritedWidgets![T];
    if (ancestor != null) {
      return dependOnInheritedElement(ancestor, aspect: aspect) as T;
    }
    _hadUnsatisfiedDependencies = true;
    return null;
  }

  @override
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor, { Object? aspect }) {
    assert(ancestor != null);
    _dependencies ??= HashSet<InheritedElement>();
    _dependencies!.add(ancestor);
    ancestor.updateDependencies(this, aspect);
    return ancestor.widget as InheritedWidget;
  }
```

通过代码对比我们可以很明显的看到dependOnInheritedWidgetOfExactType方法中调用了
dependOnInheritedElement方法，而这个方法中有更新_dependencies的操作，即更新依赖关系，但是getElementForInheritedWidgetOfExactType没有。


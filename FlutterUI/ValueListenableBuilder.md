# ValueListenableBuilder

前面我们讲到InheritedWidget 提供一种在 widget 树中从上到下共享数据的方式，但是也有很多场景数据流向并非从上到下，比如从下到上或者横向等。

为了解决这个问题，Flutter 提供了一个 ValueListenableBuilder 组件，它的功能是监听一个数据源，如果数据源发生变化，则会重新执行其 builder

```dart
const ValueListenableBuilder({
  Key? key,
  required this.valueListenable, // 数据源，类型为ValueListenable<T>
  required this.builder, // builder
  this.child,
}
```
每次this.valueListenable监听的对象发生改变都会触发this.builder方法重新构建子组件

- valueListenable：类型为 ValueListenable<T>，表示一个可监听的数据源。

- builder：数据源发生变化通知时，会重新调用 builder 重新 build 子组件树。

- child: builder 中每次都会重新构建整个子组件树，如果子组件树中有一些不变的部分，可以传递给child，child 会作为builder的第三个参数传递给 builder，通过这种方式就可以实现组件缓存，原理和AnimatedBuilder 第三个 child 相同


## 示例

```dart
class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({Key? key}) : super(key: key);

  @override
  State<ValueListenableRoute> createState() => _ValueListenableState();
}

class _ValueListenableState extends State<ValueListenableRoute> {
  // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    // 添加 + 按钮不会触发整个 ValueListenableRoute 组件的 build
    print('build');
    return Scaffold(
      appBar: AppBar(title: Text('ValueListenableBuilder 测试')),
      body: Center(
        child: ValueListenableBuilder<int>(
          builder: (BuildContext context, int value, Widget? child) {
            // builder 方法只会在 _counter 变化时被调用
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child!,
                Text('$value 次',textScaleFactor: textScaleFactor),
              ],
            );
          },
          valueListenable: _counter,
          // 当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
          child: const Text('点击了 ', textScaleFactor: textScaleFactor),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        // 点击后值 +1，触发 ValueListenableBuilder 重新构建
        onPressed: () => _counter.value += 1,
      ),
    );
  }
}
```

效果如下

![flutterui_valuelistenablebuilder]()

- `valueListenable: _counter,` 表示我们要监听的是_counter，同时_counter是ValueNotifier<Int>类型的这个类似是ValueListenable<T>的子类型。

- 当我们点击floatingActionButton时执行`_counter.value += 1`,会触发build方法被调用，build方法的第三个参数为本次build中不需要改变的child。

- 页面打开时build只会走一次，点击+号时整个页面并没有重新build，因此只打印了一次flutter: build


## 总结
关于 ValueListenableBuilder 有两点需要牢记：

- 和数据流向无关，可以实现任意流向的数据共享。

- 实践中，ValueListenableBuilder 的拆分粒度应该尽可能细，可以提高性能。


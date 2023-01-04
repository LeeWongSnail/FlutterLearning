# WillPopScope

有时候在某些编辑页面，用户输入了某些内容，或者生成了某些内容时，如果用户点击返回，需要我们给用户某些提示，才可以返回，这时候就回用到WillPopScope

WillPopScope也是一个widget，主要有onWillPop和child两个属性，分别表示点击返回时要处理的block以及组件。

```dart
const WillPopScope({
  ...
  required WillPopCallback onWillPop,
  required Widget child
})
```

onWillPop必须要返回一个结果表示是否允许返回到上一个页面，true则表示可以返回false表示不可以返回

## 示例

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    // 跳转到other 页面在该页面做返回按键点击的处理
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OtherPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
        // 回调函数，返回true 就pop 返回false 就不处理
        onWillPop: () async {
          var result = await showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                    title: const Text('再次点击就退出该页面'),
                    content: const Text('退出会返回到上一个页面'),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text('确定'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text('取消'),
                        onPressed: () => Navigator.of(context).pop(false),
                      )
                    ]);
              });
          return result;
        },

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                'jump to other page',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'jump to other page',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class OtherPage extends StatelessWidget {
  OtherPage({Key? key}) : super(key: key);
  DateTime? firstTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('hello,jack ma!'),
        ),
        body: WillPopScope(
          onWillPop: () async {
            var result = await showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                      title: const Text('再次点击就退出该页面'),
                      content: const Text('退出会返回到上一个页面'),
                      actions: [
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text('确定'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('取消'),
                          onPressed: () => Navigator.of(context).pop(false),
                        )
                      ]);
                });
            return result;
          },
          child: const Center(child: Text('I AM TOHER PAGE')),
        ));
  }
}
```

效果如下：

![flutterui_willpopscope]
# 异步UI更新（FutureBuilder、StreamBuilder）

这两个类都是用来处理依赖异步数据更新UI的场景

## FutureBuilder

通常用于网络请求，只需要单次回调的场景

```dart
FutureBuilder({
  this.future,
  this.initialData,
  required this.builder,
})
```

- future：FutureBuilder依赖的Future，通常是一个异步耗时任务。

- initialData：初始数据，用户设置默认数据。

- builder：Widget构建器；该构建器会在Future执行的不同阶段被`多次`调用


### 示例

```dart

class FutureBuilderRoute extends StatefulWidget {
  const FutureBuilderRoute({Key? key}) : super(key: key);

  @override
  _FutureBuilderRouteState createState() => _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<FutureBuilderRoute> {

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FutureBuilder'),),
      body: Center(
        child: FutureBuilder<String>(
          future: mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Text("Contents: ${snapshot.data}");
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

```

效果如下:

![flutterui_ FutureBuilder]()

这里我们通过延时操作来模拟从网络获取数据，示例代码中我们可以看到，在builder方法中，我们可以通过snapshot.connectionState获取请求的状态，其状态有一下几种

```
enum ConnectionState {
  /// 当前没有异步任务，比如[FutureBuilder]的[future]为null时
  none,

  /// 异步任务处于等待状态
  waiting,

  /// Stream处于激活状态（流上已经有数据传递了），对于FutureBuilder没有该状态。
  active,

  /// 异步任务已经终止.
  done,
}
```

## StreamBuilder

stream 因此StreamBuilder通常用于流类型的数据传输，比如上传或者下载

```dart
StreamBuilder({
  this.initialData,
  Stream<T> stream,
  required this.builder,
}) 
```

与FutureBuilder的区别是FutureBuilder需要一个future而StreamBuilder需要一个stream。


### 示例

```dart
class StreamBuilderRoute extends StatefulWidget {
  const StreamBuilderRoute({Key? key}) : super(key: key);

  @override
  _StreamBuilderRouteState createState() => _StreamBuilderRouteState();
}

class _StreamBuilderRouteState extends State<StreamBuilderRoute> {

  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('StreamBuilder'),),
      body: StreamBuilder<int>(
        stream: counter(), //
        //initialData: ,// a Stream<int> or null
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('没有Stream');
            case ConnectionState.waiting:
              return Text('等待数据...');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream 已关闭');
          }

        },
      ),
    );
  }
}
```
效果如下

![flutterui_streamBuilder]

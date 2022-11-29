
# Flutter和iOS的交互

我们的上一个示例已经实现了将flutter集成到我们现有的项目中，那么接下来我们就要看看，flutter项目如何与iOS项目进行交互了。而其中最直接的交互就是方法的调用，我们这里以页面跳转为示例来了解Flutter和iOS Native的交互。

在我们开始介绍这篇文章之前，我们先来看下下面这张图片:

![flutterAndClient]()

也许你现在还不太清楚这中间的逻辑，可以先尝试记忆，然后再接下来的文章里，配合我们的说明，来更好的了解这张图。

## 概念

在正式开始代码了解之前我们先来看看在`iOS Native`与`Flutter`交互中比较重要的几个类:

### FlutterMethodChannel

```
A channel for communicating with the Flutter side using invocation of asynchronous methods.

On the client side, MethodChannel enables sending messages that correspond to method calls.
On the platform side, MethodChannel on Android (MethodChannelAndroid) and FlutterMethodChannel on iOS (MethodChanneliOS)
enable receiving method calls and sending back a result. 
```

`通过使用调用异步方法的方式提供与flutter沟通的一个渠道`,也就是说，`iOS Native`要利用这个类与`flutter`进行交互(方法调用)

- 对客户端来说`MethodChannel`允许`发送`与方法调用相对应的`消息`

- 对`Flutter`来说`Android`上的`MethodChannel（MethodChannelAndroid）`和iOS上的`FlutterMethodChannle(MethodChanneliOS)`，支持接收来自Flutter的方法调用并返回结果。

简单来理解就是，FlutterMethodChannel可以让我们实现客户端和Flutter的互相调用。

下面是这个类常用的几个方法

```swift
/**
 * 通过指定name和binary messenger来创建一个FlutterMethodChannel
 * Creates a `FlutterMethodChannel` with the specified name and binary messenger. 
 * // name 是channel的唯一标识符
 * The channel name logically identifies the channel; identically named channels
 * interfere with each other's communication.
 * // binary messenger 是一个用来向fluttermessage
 * The binary messenger is a facility for sending raw, binary messages to the
 * Flutter side. This protocol is implemented by `FlutterEngine` and `FlutterViewController`.
 * 
 * The channel uses `FlutterStandardMethodCodec` to encode and decode method calls
 * and result envelopes.
 *
 * @param name The channel name.
 * @param messenger The binary messenger.
 */
+ (instancetype)methodChannelWithName:(NSString*)name
                      binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
/** 注册一个handler flutter中调用native的方法时会调用这个block
 * Registers a handler for method calls from the Flutter side.
 * // 可以通过设置nil来取消已注册的hanlder
 * Replaces any existing handler. Use a `nil` handler for unregistering the
 * existing handler.
 *
 * @param handler The method call handler.
 */
- (void)setMethodCallHandler:(FlutterMethodCallHandler _Nullable)handler;
```

### FlutterEventChannel

```
A channel for communicating with the Flutter side using event streams.
```

这个类的描述和`FlutterMethodChannel`有点类似，区别就是一个`using invocation of asynchronous methods`,另一个`using event streams`

通过描述我们可以很明显的知道这两种方法的区别: `FlutterEventChannel`是持续性的，而`FlutterMethodChannel`是非持续性的。我们也可以通过这个来判断，我们具体应该使用哪一个类进行交互。

下面是这个类的常用的几个方法:

```swift
/**
 * Creates a `FlutterEventChannel` with the specified name and binary messenger.
 *
 * The channel name logically identifies the channel; identically named channels
 * interfere with each other's communication.
 *
 * The binary messenger is a facility for sending raw, binary messages to the
 * Flutter side. This protocol is implemented by `FlutterViewController`.
 *
 * The channel uses `FlutterStandardMethodCodec` to decode stream setup and
 * teardown requests, and to encode event envelopes.
 *
 * @param name The channel name.
 * @param messenger The binary messenger.
 */
+ (instancetype)eventChannelWithName:(NSString*)name
                     binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

/**
 * Registers a handler for stream setup requests from the Flutter side.
 *
 * Replaces any existing handler. Use a `nil` handler for unregistering the
 * existing handler.
 *
 * @param handler The stream handler.
 */
- (void)setStreamHandler:(NSObject<FlutterStreamHandler>* _Nullable)handler;
```

这里我们也附上`FlutterStreamHandler`协议的内容:

```swift

typedef void (^FlutterEventSink)(id _Nullable event);

@protocol FlutterStreamHandler
/**
 * Sets up an event stream and begin emitting events.
 *
 * Invoked when the first listener is registered with the Stream associated to
 * this channel on the Flutter side.
 *
 * @param arguments Arguments for the stream.
 * @param events A callback to asynchronously emit events. Invoke the
 *     callback with a `FlutterError` to emit an error event. Invoke the
 *     callback with `FlutterEndOfEventStream` to indicate that no more
 *     events will be emitted. Any other value, including `nil` are emitted as
 *     successful events.
 * @return A FlutterError instance, if setup fails.
 */
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events;

/**
 * Tears down an event stream.
 *
 * Invoked when the last listener is deregistered from the Stream associated to
 * this channel on the Flutter side.
 *
 * The channel implementation may call this method with `nil` arguments
 * to separate a pair of two consecutive set up requests. Such request pairs
 * may occur during Flutter hot restart.
 *
 * @param arguments Arguments for the stream.
 * @return A FlutterError instance, if teardown fails.
 */
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments;
@end
```

## 实践出真知

在了解了`FlutterMethodChannel`和`FlutterEventChannel`这两个类之后我们下面挨个来使用实践下：


### FlutterMethodChannel

首先 我们假设现在有一个场景，从Native跳转到Flutter 然后再从Flutter返回Native,具体场景如下图gif

![FlutterMethodChannel]()


首先我们实现在Native页面点击按钮跳转到Flutter的方法

```swift
let flutterViewController = FlutterViewController(project: nil, initialRoute: "myApp", nibName: nil, bundle: nil)
flutterViewController.view.backgroundColor = .white
navigationController?.pushViewController(flutterViewController, animated: true)
```
上面的方法最简单的一个页面跳转的方法，FlutterViewController中我们指定了`initialRoute`为`home`。

下面我们要在这个基础上添加FlutterMethodChannel:

```swift
let channelName = "native/flutter"
let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
methodChannel.setMethodCallHandler { [weak self] call, result in
    print(call.method)
    
}
```
这样我们就设置了一个`methodHandler`，在`flutter`中，如果希望调用我们`Native`的方法，那么就会调用我们的`callHandler`中:

下面我们来看下flutter中的代码:

首先，我们要在flutter中创建一个MethodChannel，同时必须指定与Native中name相同

```dart
// 创建一个给native的channel 类似iOS通知
static const methodChannel = const MethodChannel('native/flutter');
```

在我们视图中的返回按钮:

```dart
appBar: AppBar(
  title: Text(widget.title),
  leading: InkWell(
    onTap: () {
      methodChannel.invokeMethod('backToViewController');
    },
    child: Icon(
      Icons.arrow_back,
      color: Colors.white,
    ),
  ),
),
```
我们看到UI空间在点击返回时调用了backToViewController方法，而调用方式为: `methodChannel.invokeMethod('backToViewController');`,那么当我们点击返回按钮时Native代码的block中就会有回调:

![backtopredidclick]()

这就是一个简单的方法调用，但是如果我们希望传递参数呢？

我们继续在Flutter页面中添加一个InkWell:

```dart
 InkWell(
  onTap: _iosPushToVC,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(Icons.forward),
      Text('跳转到iOS新界面，参数是字符串'),
    ],
  ),
),
```
点击时绑定了_iosPushToVC，然后我们实现这个方法

```dart
_iosPushToVC() async {
  await methodChannel.invokeMethod('iOSFlutter', '这是flutter传递的字符串');
}
```
这个方法的试下我们增加了一个参数，第一个参数是方法名第二个参数表示调用这个方法要传递的参数:

```dart
@optionalTypeArgs
Future<T?> invokeMethod<T>(String method, [ dynamic arguments ]) {
  return _invokeMethod<T>(method, missingOk: false, arguments: arguments);
}
```
我们通过这个定义可以看到 arguments是一个dynamic类型的，因此参数不仅仅可以是字符串也可以是其他类型，比如

```dart
_iosGetMap() async {
  Map<String, dynamic> value = {'code': '200', 'data': [1,2,3]};
  await methodChannel.invokeMethod('iosFlutter1', value);
}
```
这个方法中我们传递的就是一个Map。

上面几个方法我们演示了Flutter调用Native方法的形式，但是方法都没有返回值，那么我们如何调用一个有返回值的方法呢？`由于方法都是异步，这里的返回值我们可以理解为是方法执行完成的block`

```dart
_getIosValue() async {
  dynamic reslut;
  try {
    reslut = await methodChannel.invokeMethod('iosFlutter2');
  } on PlatformException {
    reslut = 'error';
  }

  if (reslut is String) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Container(
        child: Center(
          child: Text(reslut, style: TextStyle(color: Colors.brown), textAlign: TextAlign.center,),
        ),
        height: 40,
      );
    });
  }
}
```
这时候我们要在Native实现时需要这么写

```swift
@objc func showFlutter() {
  let flutterViewController = FlutterViewController(project: nil, initialRoute: "myApp", nibName: nil, bundle: nil)
    flutterViewController.view.backgroundColor = .white
    let channelName = "native/flutter"
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
    methodChannel.setMethodCallHandler { [weak self] call, result in
        print(call.method)
        
        if call.method == "iosFlutter2" {
            result("这是native返回给flutter的值")
        }
    }
    navigationController?.pushViewController(flutterViewController, animated: true)
    
}
```

之前一直忽略了`MethodCallHandler`中的第二个参数result 现在我们来看下:

```swift
/**
 * A method call result callback.
 *
 * Used for submitting a method call result back to a Flutter caller. Also used in
 * the dual capacity for handling a method call result received from Flutter.
 *
 * @param result The result.
 */
typedef void (^FlutterResult)(id _Nullable result);

/**
 * A strategy for handling method calls.
 *
 * @param call The incoming method call.
 * @param result A callback to asynchronously submit the result of the call.
 *     Invoke the callback with a `FlutterError` to indicate that the call failed.
 *     Invoke the callback with `FlutterMethodNotImplemented` to indicate that the
 *     method was unknown. Any other values, including `nil`, are interpreted as
 *     successful results.  This can be invoked from any thread.
 */
typedef void (^FlutterMethodCallHandler)(FlutterMethodCall* call, FlutterResult result);
```

从上面的解释中我们可以看到

- call 要调用的方法对象，内部包含name方法名以及arguments方法参数
- result 一个异步回调用来提交call方法的执行结果 同时可以返回一个参数 参数类型可以是任意类型

通过这个方式我们可以动态的调用Native方法，或者从Native中获取数据。

上面的例子都是Native中通过handler监听flutter中的方法调用，那么native是否可以主动调用flutter中的方法呢？

```swift
 DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
     methodChannel.invokeMethod("iosInvokeFlutter", arguments: "argument from native") { result in
         print(result)
     }
 }
```
我们在页面跳转到flutter后5s 在native执行一个flutter方法，并在flutter中设置callHandler：

```dart
methodChannel.setMethodCallHandler((call) async {
    if (call.method == "iosInvokeFlutter") {
       _iosPushToVC();
       return "flutter 回传给 native的数据";
    }
});
```

这样在外部调用到invokeMethod时：

![nativecallflutter]()

因此 FlutterMethodChannel实际是一个双向的方法，既可以在iOS中主动调用Flutter中的方法，也可以在flutter主动调用Native的方法。


### FlutterEventChannel

同样的方式，我们在native跳转至flutter时:

```swift
let eventChannelName = "wg/native_post"
let eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: flutterViewController.binaryMessenger)
eventChannel.setStreamHandler(self)
```

然后我们需要让当前页面遵守对应协议:

```swift
extension FirstViewController: FlutterStreamHandler {
	// 监听到某个事件(Flutter触发)
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {

    }
    // 取消事件流
    func onCancel(withArguments arguments: Any?) -> FlutterError? {

    }
}
```


在flutter中，我们同样需要定义一个EventChannel:

```dart
static const EventChannel eventChannel = const EventChannel('wg/native_post');
```

在flutter中我们可以通过下面这种方式来给Native传递消息

```dart
@override
void initState() {
  // TODO: implement initState
  super.initState();
  // 监听事件同时发送参数 12345
  eventChannel.receiveBroadcastStream(12345).listen(_onEvent,onError: _onError);
  WidgetsBinding.instance.addObserver(this);
}
```
这时候，就会触发Native中的代理方法

![broadcaststream]()

我们可以获取到`argument=12345`，`events`为传入的`function`。这时候我们就可以在Native获取到flutter的方法。

那么我们可以选择在某一个时机去执行这个方法:

```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    self.eventSink?("这是我外部设置的值")
}
```
效果如下:

![eventinvockinswift]()

当然这个function我们也可以在回调里接收到后立即执行，这样flutter中就可以及时的获取到所需数据

```swift
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        NSMutableDictionary * params = [NSMutableDictionary dictionaryWithCapacity:0];
        [params setValue:mReferNo forKey:@"ataNo"];
        [params setValue:mDocType forKey:@"docType"];
        [params setValue:self.aircraftNo forKey:@"aircraftNo"];
//        [params setValue:[[NetworkingTools networkHeaders]   modelToJSONString] forKey:@"headers"];
//        [params setValue:[NetworkingTools networkHeaders] forKey:@"headers"];
        [params setValue:@"我是标题" forKey:@"title"];
        [params addEntriesFromDictionary:[NetworkingTools networkHeaders] ];
        events([params modelToJSONString]);
    }
    return nil;
}
```


### FlutterMethodChannel/FlutterEventChannel

- FlutterMethodChannel是双向通讯，FlutterEventChannel是iOS调用Flutter的单向通讯
- FlutterMethodChannel是单次通讯，FlutterEventChannel是持续性通讯
- 都支持参数和返回值



### 参考

[iOS 与 Flutter 通信之 MethodChannel](https://juejin.cn/post/7012905714418974728/)
[iOS 与 Flutter 通信之 EventChannel](https://juejin.cn/post/7012955190580445197/)


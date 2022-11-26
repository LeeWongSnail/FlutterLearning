# 将Flutter集成到现有项目中

先描述下我现在的环境

- Xcode 14.0
- iOS 16.0
- Flutter 2.5.3 • channel stable • https://github.com/flutter/flutter.git
- Framework • revision 18116933e7 (1 year, 1 month ago) • 2021-10-15 10:46:35 -0700
- Engine • revision d3ea636dc5
- Tools • Dart 2.14.4

## 创建Flutter Module

目前我的已有项目FlutterDemo已经存在了，所以我需要在同目录下创建一个my_flutter目录用来存放flutter相关代码

![flutterdemobefore]()

我们通过：

```
flutter create --template module my_flutter
```
命令来创建我们的my_flutter目录

![createfluttermodulecmd]()

创建后的目录结构基本如下

```
my_flutter/
├── .ios/
│   ├── Runner.xcworkspace
│   └── Flutter/podhelper.rb
├── lib/
│   └── main.dart
├── test/
└── pubspec.yaml

```
其中:

- pubspec.yaml 是后续可能需要添加的flutter依赖文件 类似pod的podfile
- lib 是flutter代码的文件目录，后续的flutter代码主要在这里完成
- .ios文件夹内 隐藏了一个Xcode Wordkspace,用于独立运行Flutter module,它是一个独立启动Flutter代码的壳工程，并且包含一个帮助脚本，用于编译frameworks或者使用CocoaPods将flutter module集成到应用中。

`注意`： 我们的iOS相关代码都不是写在.ios文件夹下的壳工程中的，是写在我们自己的主工程中的，这个Runner.xcworkspace可以看做pod的一个示例工程。

而且由于.ios目录无法自动生成，在新机器上构建module时，在使用flutter module构建我们自己的应用之前，在my_flutter目录下运行 flutter pub get 以生成新的.ios目录。

## 集成到现有项目中

这里我们选择的是官方推荐的使用CocoaPods的方式

在正式开始之前我们还是来看下我们现在的目录结构(添加my_flutter之后):

```
some/path/
├── my_flutter/
│   └── .ios/
│       └── Flutter/
│         └── podhelper.rb
└── FlutterDemo/
    └── Podfile

```
如果我们的项目还没有Podfile，可以使用`pod init`命令创建一个

### 修改Podfile文件

#### 添加load代码

```
flutter_application_path = '../my_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
```

#### target install

每个需要集成Flutter的 Podfile Target 都需要添加,下面这个命令

```
target 'MyApp' do
  install_all_flutter_pods(flutter_application_path)
end
```

#### post_install

在Podfile的post_install 部分添加调用(如果当前没有pod_install则新增)

```
post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
```

`flutter_post_install` 方法（近期新增的）增加了原生` Apple Silicon arm64 iOS` 模拟器的支持。它包括 `if defined?(flutter_post_install)` 的检查以确保你的` Podfile` 在旧版本的没有该方法的` Flutter` 上也能正常运行。

#### pod install

我们在自己的flutterDemo项目目录下执行pod install。

![flutterpodinstall]()

`提示`: 如果后续在`my_flutter/pubspec.yaml`中改变了改变了`Flutter plugin` 依赖，需要在` Flutter module` 目录(my_flutter)运行 `flutter pub get`，来更新会被`podhelper.rb` 脚本用到的` plugin `列表，然后再次在你的应用目录 `some/path/FlutterDemo` 运行 `pod install`.

podhelper.rb会把plugins, flutter.frameword以及App.frameword集成到我们的项目中。

`提示`: Flutter.frameword是Flutter engine的框架，App.framework是Dart代码编译的产物。

经过上面的几步操作我们就可以直接打开我们的FlutterDemo.xcworkspace项目了。


其他的几种方式官方文档都有介绍，如果想了解可以看[这里](https://flutter.cn/docs/development/add-to-app/ios/project-setup#local-network-privacy-permissions),本篇文章就不在介绍了

### Info.plist文件修改

我们在创建项目的时候默认都会有一个Info.plist,这里我们要把这个文件拆分成Debug和Release两个文件

#### 创建两个文件

具体方式为:
- 直接修改Info.plist文件为 Info-Debug.plist
- 复制一个Info-Debug.plist文件的副本 改名为 Info-Release.plist
- 将这两个文件的引用到放到工程引用下

#### 修改info-Debug.plist文件

在info-Debug.plist文件中添加key为NSBonjourServices的配置(数组)，添加一个值为NSBonjourServices的item `_dartobservatory._tcp`。

在添加一个本地网络权限的描述`Privacy - Local Network Usage Description`，具体的值可以根据自己的项目来设置

```
<key>NSLocalNetworkUsageDescription</key>
	<string>要使用本地网络的权限这里填写合适的描述文案</string>
	<key> NSBonjourServices</key>
	<array>
		<string>_dartobservatory._tcp</string>
	</array>
```

![flutterdebuginfo.plist]()

#### 修改Build Settings

为了让我们的修改生效，我们还需要在Build Settings中进行配置

![infoplistbuildsettings]()

至此我们的项目配置就完成了，下面我们开始向页面中添加flutter页面代码

## 添加一个fluter页面并实现跳转

这里开始我们跟官方的文档有些不一样了，因为我按照官方文档的步骤一直有问题。但是我们还是按照官方的步骤来。

### FlutterEngin 和 FlutterViewController

在正式开始之前我们先了解下这两个类

- FlutterEngine 充当 Dart VM 和 Flutter 运行时的主机
-  FlutterViewController 依附于 FlutterEngine，给 Flutter 传递 UIKit 的输入事件，并展示被 FlutterEngine 渲染的每一帧画面。

`提示`：
通常建议为应用预热一个`长寿`(Flutter Engin)>(FlutterViewController)的FlutterEngine，因为:

- 在展示第一个FlutterViewController页面时，页面会很快展示
- Flutter和Dart状态比FlutterViewController生命周期更长
- 在UI展示前plugins可以与Flutter和Dart进行逻辑交互

### 创建一个FlutterEngin

```
import UIKit
import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run();
    // Used to connect plugins (only if you have plugins with iOS platform code).
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
}

```

我们可以直接将这段代码复制到我们的AppDelegate.swift文件中，这里主要做了一下几件事

- 原有的AppDelegate改为继承自FlutterAppDelegate,这样会帮我们省去一部分监听代码
- 创建了一个flutterEngine 

```swift
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
```

- 调用flutterEngine run方法，这种情况下flutterEngine明显`更长寿`,这里我们需要知道我们默认调用run方法时也表示我们调用flutter的代码默认入口函数是main（）
- 注册新建的flutterEngine
```swift
GeneratedPluginRegistrant.register(with: self.flutterEngine)
```

`注意`: 我们这里先不深入了解run方法和register方法，后续我们遇到具体场景或者问题时会详细讲。

### 使用 FlutterEngine 展示 FlutterViewController

下面我们准备要展示Flutter页面了，我们在页面中添加一个按钮，点击按钮可以展示出一个Flutter的页面

```swift
import UIKit
import Flutter

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Make a button to call the showFlutter function when pressed.
    let button = UIButton(type:UIButton.ButtonType.custom)
    button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
    button.setTitle("Show Flutter!", for: UIControl.State.normal)
    button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
    button.backgroundColor = UIColor.blue
    self.view.addSubview(button)
  }

  @objc func showFlutter() {
    let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
    let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    present(flutterViewController, animated: true, completion: nil)
  }
}

```
添加按钮的方法很简单，我们主要来看下`showFlutter `这个方法:

- 获取刚才创建的FlutterEngine,这里是直接依赖AppDelegate获取，后续在自己的项目中可以优化
- 创建一个flutterViewController，传入的第一个参数为我们已经预热的flutterEngine

这里官方文档还介绍了另外一种方式可以让我们不用继承自FlutterAppDelegate，我们可以通过实现FlutterAppLifeCycleProvider协议，这里我们也先不多说，这篇文章的重点也不在于此。

## 编写flutter代码

我这里是使用的Android Studio作为编辑器，我们可以直接打开my_flutter这个文件夹，然后再lib中的main.dart中进行代码编写。

因为这里我们只是想确定是否可以真的跳转成功，所以，我直接在网上找了一个代码，直接粘贴，这里先不需要知道怎么写，这篇文章的主要目的是原生跳转flutter成功。

```flutter
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter jump Native'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //平台通道1––––获取电池电量
  static const platform = const MethodChannel('samples.flutter.dev/battery');
  //平台通道2––––跳转到iOS页面
  static const platform2 = const MethodChannel('samples.flutter.jumpto.iOS');
  //平台通道3––––跳转到Android页面
  static const platform3 = const MethodChannel('samples.flutter.jumpto.android');


  String _batteryLevelStr = 'Unknown battery level.';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: _getBatteryLevelMethod, child: Text('获取电池电量')),
            Text(_batteryLevelStr),
            SizedBox(height: 20,),


            TextButton(onPressed: _jumpToIosMethod, child: Text('跳转到iOS页面')),
            TextButton(onPressed: _jumpToAndroidMethod, child: Text('跳转到Android页面')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //获取电池电量
  Future<Null> _getBatteryLevelMethod() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');

      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevelStr = batteryLevel;
    });
  }

  //跳转到iOS页面
  Future<Null> _jumpToIosMethod() async {
    final String result = await platform2.invokeMethod('jumpToIosPage');
    print('result===$result');

  }
  //跳转到Android页面
  Future<Null> _jumpToAndroidMethod() async {
    final String result = await platform3.invokeMethod('jumpToAndroidPage');
    print('result===$result');

  }


}
```

至此，我们所有的前期准备都已经完成，下面就是点击神圣的Run按钮，看下是否可以顺利的运行并达到我们期待的效果吧。

Too Young Too Simple,怎么可能这么顺利，我们来看下遇到的问题。

## 问题

按照官方文档的说法，到目前位置我们就可以运行成功了，但是好事多磨，我在这个过程中遇到了下面这些问题

### Failed to find assets path for "Frameworks/App.framework/flutter_assets"

我们在运行起来项目后发现，点击按钮后并没有实现跳转，通过搜索，我找到了下面这个而解决方案

在Target-BuildPhase中添加run Script

```
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" build
"$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" embed ${SOURCE_ROOT}/Flutter/App.framework
```
添加后如下：

![buildphaseaddrunscript]()

再次编译后，提示没有找到FLUTTER_ROOT路径，因此我们需要关联我们的Flutter路径

在buildSetting中新增 User-Define setting

![buldsettingaddsetting]()

新增结果如下:

![userdefinesetting]()

这样我们再次进行编译就可以成功了

如果我的这种方法，对你不适用，你可以看下[这里](https://github.com/flutter/flutter/issues/29974)以及[这里](https://stackoverflow.com/questions/61144408/failed-to-find-assets-path-for-frameworks-app-framework-flutter-assets)


### xcode flutter fopen failed for data file: errno = 2 (No such file or directory)

很不幸我们还有这么一个问题,通过搜索我们发现，需要修改的是这里

![errorno2fixmethod]()

主要是这里的LaunchScreenInterface,好奇怪为什么是修改这里，但是的确是生效了

我参考的是flutter中的这个[issue](https://github.com/flutter/flutter/issues/109517)

### 总结

至此我们已经实现了`原生跳转flutter`这一目标，后续我们会继续看`flutter跳转原生`以及`原生和flutter之间的参数传递`。

![nativetoflutter]()




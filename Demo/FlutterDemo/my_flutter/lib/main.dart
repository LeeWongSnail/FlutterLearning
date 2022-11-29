import 'package:flutter/material.dart';
//引入下面这个，是为了调用window的defaultRouteName拿到route判断跳转哪个界面
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:my_flutter/flutter_first.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'myApp':
      return MyApp();
    case 'home':
      return FlutterFirst();
    default:
      return MyApp();
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter 跳转测试",
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      routes: <String, WidgetBuilder> {
        "/home":(BuildContext context) => FlutterFirst()
      },
      home: MyHomePage(title: "我是flutter-->MyHomePage页面",),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title,}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  
  // 创建一个给native的channel 类似iOS通知
  static const methodChannel = const MethodChannel('native/flutter');

  // 告诉iOS 需要跳转到下一页 iOS自己进行跳转 这里可以传递一个参数
  _iosPushToVC() async {
    await methodChannel.invokeMethod('iOSFlutter', '这是flutter传递的字符串');
  }

  // 调用native的iosFlutter1方法并传递一个map数据
  _iosGetMap() async {
    Map<String, dynamic> value = {'code': '200', 'data': [1,2,3]};
    await methodChannel.invokeMethod('iosFlutter1', value);
  }

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 添加一个观察者
    WidgetsBinding.instance.addObserver(this);
    
    methodChannel.setMethodCallHandler((call) async {
        if (call.method == "iosInvokeFlutter") {
           _iosPushToVC();
           return "flutter 回传给 native的数据";
        }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    // 如果状态改变会调用这个方法
    if (state != AppLifecycleState.resumed) {
      methodChannel.invokeMethod('changeNavStatus','didChangeAppLifecycleState:${state}-show');
    } else {
      methodChannel.invokeMethod('changeNavStatus', 'didChangeAppLifecycleState:${state}-hidden');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            InkWell(
              onTap: _iosGetMap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.forward),
                  Text('传参 参数是Map')
                ],
              ),
            ),
            InkWell(
              onTap: _getIosValue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.forward),
                  Text('接受iOS传递的内容')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



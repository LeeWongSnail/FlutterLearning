import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterFirst extends StatefulWidget {
  @override
  _FlutterFirstState createState() => _FlutterFirstState();
}

class _FlutterFirstState extends State<FlutterFirst> with WidgetsBindingObserver {

  // 注册一个通知监听原生传给flutter的值
  static const EventChannel eventChannel = const EventChannel('wg/native_post');
  static const MethodChannel methodChannel = const MethodChannel('wg/native_get');

  // 渲染前的操作 类似viewDidLoad
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 监听事件同时发送参数 12345
    eventChannel.receiveBroadcastStream(12345).listen(_onEvent,onError: _onError);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }



  String navTitle = 'title';

  void _onEvent(dynamic event) {
    setState(() {
      navTitle = event.toString();
    });
  }

  void _onError(Object error) {

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if(state != AppLifecycleState.resumed){
      methodChannel.invokeMethod('changeNavStatus', 'didChangeAppLifecycleState:${state}-show');
    }else{
      methodChannel.invokeMethod('changeNavStatus', 'didChangeAppLifecycleState:${state}-hiden');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我是flutter-->FlutterFirst页面',
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      home: Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text('我是flutter-->FlutterFirst页面'),
            leading: InkWell(
              onTap: (){
                methodChannel.invokeMethod('backToViewController');
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Center(
            child: Text(navTitle),
          ),
        ),
      ),
    );
  }
}

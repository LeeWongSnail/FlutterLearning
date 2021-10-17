import 'package:flutter/material.dart';
import 'second_page.dart';
import 'custom_router_animation.dart';

class RouterPages extends StatelessWidget {
  const RouterPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('First Page', style: TextStyle(fontSize: 30.0),),
        // 导航和页面之间是否有阴影
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(Icons.navigate_next, color: Colors.white, size: 64,),
          onPressed: (){
            Navigator.of(context).push(CustomRouterAnimation(SecondPage()));
          },
        ),
      ),
    );
  }
}
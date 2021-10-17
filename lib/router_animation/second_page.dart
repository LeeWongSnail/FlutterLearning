import 'package:flutter/material.dart';
import 'package:flutter_learnings/router_animation/second_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text('SecondPage', style: TextStyle(fontSize: 36.0),),
        elevation: 4.0,
        backgroundColor: Colors.pinkAccent,
        leading: Container(),
      ),
      body: Center(
        child: MaterialButton(child: Icon(Icons.navigate_before, color: Colors.white, size: 64,),onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
    );
  }
}

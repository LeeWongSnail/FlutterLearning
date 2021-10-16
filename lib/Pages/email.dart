import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email'),
      ),
      body: Center(
        child: Text('Email Page'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';

class BlurView extends StatelessWidget {
  const BlurView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 相同层级的栈
      body: Stack(
        children: [
          // 添加额外的约束条件 约束child
          ConstrainedBox(constraints: const BoxConstraints.expand(), child: Image.network('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnimg.ws.126.net%2F%3Furl%3Dhttp%253A%252F%252Fdingyue.ws.126.net%252F2021%252F0524%252F7b2d3473j00qtkj6o003bc000hs012hc.jpg%26thumbnail%3D650x2147483647%26quality%3D80%26type%3Djpg&refer=http%3A%2F%2Fnimg.ws.126.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637030399&t=b56f5c4a5d1c1cf7365d26591bf2bde9'),),
          Center(
            child: ClipRect(
              // 可裁切的矩形
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Opacity(
                  opacity: 0.1,
                  child: Container(
                    width: 500.0,
                    height: 1000.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                        child: Text('Blur View',style: TextStyle(color: Colors.red),),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

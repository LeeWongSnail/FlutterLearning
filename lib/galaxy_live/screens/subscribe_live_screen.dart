import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learnings/galaxy_live/view_model/subscribe_live_screen_view_model.dart';
import 'package:flutter_learnings/galaxy_live/view_model/subscribe_live_view_model.dart';
import 'package:flutter_learnings/galaxy_live/views/subscribe_live_widget.dart';

class SubscribeLiveScreen extends StatelessWidget {
  const SubscribeLiveScreen({Key? key}) : super(key: key);

  // 需要准备数据

  @override
  Widget build(BuildContext context) {
    debugPrint("SubscribeLiveScreen -- build");
    // 这里根据数据生成一个视图进行返回
    var viewModel = context.watch<SubscribeLiveScreenViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("预约观看直播间"),
      ),
      backgroundColor: Color(0xfff7f7fa),
      body: ListView.builder(
        itemCount: viewModel.cards.length,
        itemBuilder: (context, index) {
          // 返回listView中每一行的数据
          return ChangeNotifierProvider.value(value: viewModel.cards[index], child: const SubscribeLiveCard(),);
        },
      ),
    );


    return Container();
  }
}


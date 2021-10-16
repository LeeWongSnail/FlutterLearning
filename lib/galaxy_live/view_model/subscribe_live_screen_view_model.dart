import 'package:flutter/material.dart';
import 'package:flutter_learnings/galaxy_live/models/user.dart';
import 'subscribe_live_view_model.dart';
import 'package:flutter_learnings/galaxy_live/models/live_model.dart';

class SubscribeLiveScreenViewModel extends ChangeNotifier {
  List<SubScribeLiveViewModel> cards;
  
  SubscribeLiveScreenViewModel(this.cards);
  
  static Future<SubscribeLiveScreenViewModel> fetchSubscribeLives() async {
    // 异步获取预约直播间列表信息
    return Future.delayed(const Duration(microseconds: 200), () {
      final lives = [LiveModel("测试直播间", "https://tva1.sinaimg.cn/large/008i3skNly1gvbfcdc4aaj61b50u0wq602.jpg", UserModel("https://tva1.sinaimg.cn/large/008i3skNly1gvbi1lcinsj60dw0dwwew02.jpg","LeeWong","主播"), "直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍", 300, 500),
        LiveModel("测试直播间1", "https://tva1.sinaimg.cn/large/008i3skNly1gvbfcdc4aaj61b50u0wq602.jpg", UserModel("https://tva1.sinaimg.cn/large/008i3skNly1gvbi1lcinsj60dw0dwwew02.jpg","LeeWong","主播"), "直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍", 300, 500),
        LiveModel("测试直播间2", "https://tva1.sinaimg.cn/large/008i3skNly1gvbfcdc4aaj61b50u0wq602.jpg", UserModel("https://tva1.sinaimg.cn/large/008i3skNly1gvbi1lcinsj60dw0dwwew02.jpg","LeeWong","主播"), "直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍", 300, 500),
        LiveModel("测试直播间3", "https://tva1.sinaimg.cn/large/008i3skNly1gvbfcdc4aaj61b50u0wq602.jpg", UserModel("https://tva1.sinaimg.cn/large/008i3skNly1gvbi1lcinsj60dw0dwwew02.jpg","LeeWong","主播"), "直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍", 300, 500),
        LiveModel("测试直播间4", "https://tva1.sinaimg.cn/large/008i3skNly1gvbfcdc4aaj61b50u0wq602.jpg", UserModel("https://tva1.sinaimg.cn/large/008i3skNly1gvbi1lcinsj60dw0dwwew02.jpg","LeeWong","主播"), "直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍直播的简单介绍", 300, 500)].map((e) => SubScribeLiveViewModel(e)).toList();
      return SubscribeLiveScreenViewModel(lives);
    });
  }
}

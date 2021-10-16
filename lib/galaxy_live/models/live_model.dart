import 'user.dart';
/// 直播间 Model.
class LiveModel {
  // 标题
  String title;
  // 直播间封面
  String? iconImageURL;
  // 用户信息
  UserModel author;
  // 直播简介
  String? liveDesc;
  // 预约人数
  int subscribeCount = 0;
  // 直播间人数
  int liveRoomCount = 0;
  // 构造方法
  LiveModel(this.title, this.iconImageURL, this.author, this.liveDesc, this.subscribeCount, this.liveRoomCount);
}

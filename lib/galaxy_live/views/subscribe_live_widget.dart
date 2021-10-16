import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learnings/galaxy_live/models/live_model.dart';
import 'package:flutter_learnings/galaxy_live/models/user.dart';
import 'package:flutter_learnings/galaxy_live/view_model/subscribe_live_view_model.dart';
import 'package:provider/provider.dart';

class LiveCardUtil {
  static Size boundingTextSize(BuildContext context, String text, TextStyle style,  {int maxLines = 2^31, double maxWidth = double.infinity}) {
    if (text == null || text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(context),
        text: TextSpan(text: text, style: style), maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}

class SubscribeLiveCard extends StatelessWidget {
  const SubscribeLiveCard({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    debugPrint("SubscribeLiveCard widget build....");

    final cardViewModel = context.watch<SubScribeLiveViewModel>();
    
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
              child: Text(
                cardViewModel.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child: Container(
                  height: 242,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            cardViewModel.live.iconImageURL ?? "")),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: LiveAuthorRow(cardViewModel.live.author),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: LiveIntroduceView(cardViewModel.live.liveDesc),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: LiveSubscribeInfo(cardViewModel.live),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
              child: LiveCardFunctionWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class LiveAuthorRow extends StatelessWidget {
  UserModel user;
  LiveAuthorRow(this.user);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(user.icon ?? "", width: 32, height: 32,fit: BoxFit.cover,),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 10, 0),
          child: Text(user.name, style: TextStyle(
            fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold
          ),),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 10, 0),
          child: Text(user.role ?? "", style: TextStyle(
            color: Color(0xFFA6A6A6),
            fontSize: 12,
          ),),
        ),
      ],
    );
  }
}

class LiveIntroduceView extends StatelessWidget {
  String? liveIntroduce;

  LiveIntroduceView(this.liveIntroduce);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        liveIntroduce ?? "",
        style: TextStyle(
          color: Color(0xff636363),
          fontSize: 12,
        ),
      ),
    );
  }
}

class LiveSubscribeInfo extends StatelessWidget {
  LiveModel? live;
  LiveSubscribeInfo(this.live);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('${live?.subscribeCount}人预约', style: TextStyle(
               color: Color(0xff646464),
               fontSize: 12,
             ),),
             Text('直播间人数: ${live?.liveRoomCount}', style: TextStyle(
               color: Color(0xff646464),
               fontSize: 12,
             ),),
           ],
         ),
         Padding(
           padding: const EdgeInsets.only(right: 10),
           child: TextButton(
             child: Text("进入直播间", style: TextStyle(color: Color(0xff00CB94), fontSize: 11),),
             onPressed: null,
             style: ButtonStyle(
               padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 0, 20, 0)),
               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
               side: MaterialStateProperty.all(BorderSide(color:Color(0xff00CB94), width: 1.0)),
               backgroundColor: MaterialStateProperty.all(Colors.white),
             ),
           ),
         ),
       ],
      ),
    );
  }
}

class LiveCardFunctionWidget extends StatelessWidget {
  const LiveCardFunctionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: null,
              child:  Text("取消预约", style: TextStyle(color: Color(0xffAFAFAF), fontSize: 11),),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40, 0, 40, 0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                side: MaterialStateProperty.all(BorderSide(color:Color(0xffAFAFAF), width: 1.0)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
          TextButton(
            onPressed: null,
            child:  Text("详情", style: TextStyle(color: Color(0xff00CB94), fontSize: 11),),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40, 0, 40, 0)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
              side: MaterialStateProperty.all(BorderSide(color:Color(0xff00CB94), width: 1.0)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


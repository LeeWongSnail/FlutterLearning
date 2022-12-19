//
// class ScrollControllerTestRoute extends StatefulWidget {
//   const ScrollControllerTestRoute({Key? key}) : super(key: key);
//
//   @override
//   _ScrollControllerTestRouteState createState() => _ScrollControllerTestRouteState();
// }
//
// class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
//
//   ScrollController _scrollController = ScrollController();
//
//   // 是否展示回到顶部按钮
//   bool showToTopBtn = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _scrollController.addListener(() {
//       print(_scrollController.offset);
//       if (_scrollController.offset < 1000 && showToTopBtn) {
//         setState(() {
//           showToTopBtn = false;
//         });
//       } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
//         setState(() {
//           showToTopBtn = true;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: Text('滚动监听'),),
//       body: Scrollbar(
//         child: ListView.builder(itemBuilder: (context, index){
//           return ListTile(title: Text('$index'),);
//         }, itemCount: 100,itemExtent: 50, controller: _scrollController,),
//       ),
//       floatingActionButton: !showToTopBtn ? null : FloatingActionButton(onPressed: (){
//         _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
//       }, child: Icon(Icons.arrow_upward),),
//     );
//   }
// }

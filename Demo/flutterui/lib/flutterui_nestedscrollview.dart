//
//
// class NestedScrollViewRoute extends StatelessWidget {
//   const NestedScrollViewRoute({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               title: Text('NestedScrollView'),
//               pinned: true,
//               forceElevated: innerBoxIsScrolled,
//             ),
//             buildSliverList()
//           ];
//         },
//         body: ListView.builder(itemBuilder: (BuildContext context, int index){
//           return SizedBox(
//             height: 50,
//             child: Center(child: Text('Item $index'),),
//           );
//         }, padding:  EdgeInsets.all(8), physics: ClampingScrollPhysics(), itemCount: 30,),
//       ),
//     );
//   }
//   Widget buildSliverList() {
//     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 5), itemExtent: 56);
//     return listView;
//   }
// }
//
// class NestedTabBarView extends StatelessWidget {
//   const NestedTabBarView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _tabs = ['猜你喜欢','今日特价', '发现更多'];
//     return DefaultTabController(length: _tabs.length, child: Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//               sliver: SliverAppBar(
//                 title: Text('商城'),
//                 floating: true,
//                 snap: false, // 是否固定在顶部
//                 forceElevated: innerBoxIsScrolled,
//                 bottom: TabBar(
//                   tabs: _tabs.map((e) => Tab(text: e,)).toList(),
//                 ),
//               ),),
//           ];
//         },
//         body: TabBarView(
//           children: _tabs.map((e) {
//             return Builder(builder: (BuildContext context) {
//               return CustomScrollView(
//                 key: PageStorageKey(e),
//                 slivers: [
//                   SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
//                   SliverPadding(padding: EdgeInsets.all(8),sliver: buildSliverList(),),
//                 ],
//               );
//             });
//           }).toList(),
//         ),
//       ),
//     ));
//   }
//
//   Widget buildSliverList() {
//     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 100), itemExtent: 56);
//     return listView;
//   }
// }
//
//
// class SnapAppBar2 extends StatefulWidget {
//   const SnapAppBar2({Key? key}) : super(key: key);
//
//   @override
//   _SnapAppBar2State createState() => _SnapAppBar2State();
// }
//
// class _SnapAppBar2State extends State<SnapAppBar2> {
//
//   late SliverOverlapAbsorberHandle handle;
//
//   void onOverlapChanged() {
//     print(handle.layoutExtent);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
//           handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);
//           handle.removeListener(onOverlapChanged);
//           handle.addListener(onOverlapChanged);
//
//           return [
//             SliverOverlapAbsorber(handle: handle, sliver: SliverAppBar(
//               floating: true,
//               snap: true,
//               expandedHeight: 200,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Image.asset(
//                   "/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               forceElevated: innerBoxIsScrolled,
//             ),)
//           ];
//         },
//         body: LayoutBuilder(builder: (BuildContext context, cons) {
//           return CustomScrollView(
//             slivers: [
//               SliverOverlapInjector(handle: handle),
//               buildSliverList()
//             ],
//           );
//         },),
//       ),
//     );
//   }
//
//   Widget buildSliverList() {
//     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 100), itemExtent: 56);
//     return listView;
//   }
// }
//
//
//
// //
// // class SnapAppBar extends StatelessWidget {
// //   const SnapAppBar({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: NestedScrollView(
// //         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
// //           return [
// //             SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
// //               sliver: SliverAppBar(
// //                 floating: true,
// //                 snap: true,
// //                 expandedHeight: 200,
// //                 forceElevated: innerBoxIsScrolled,
// //                 flexibleSpace: FlexibleSpaceBar(
// //                   background: Image.asset(
// //                     "/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp",
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //
// //           ];
// //         },
// //         body: Builder(builder: (BuildContext context) {
// //           return CustomScrollView(
// //             slivers: [
// //               SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
// //               buildSliverList(),
// //             ],
// //           );
// //         },),
// //       ),
// //     );
// //   }
// //
// //   Widget buildSliverList() {
// //     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
// //       return ListTile(title: Text('$index'),);
// //     }, childCount: 100), itemExtent: 56);
// //     return listView;
// //   }
// // }
//
//
// class SnapAppBar extends StatelessWidget {
//   const SnapAppBar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NestedScrollView(
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             SliverAppBar(
//               floating: true,
//               snap: true,
//               expandedHeight: 200,
//               forceElevated: innerBoxIsScrolled,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Image.asset("/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp", fit: BoxFit.cover,),
//               ),
//             )
//           ];
//         },
//         body: Builder(builder: (BuildContext context) {
//           return CustomScrollView(
//             slivers: [
//               buildSliverList()
//             ],
//           );
//         },),
//       ),
//     );
//   }
//
//   Widget buildSliverList() {
//     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 100), itemExtent: 56);
//     return listView;
//   }
// }

//
// class TabViewRoute2 extends StatelessWidget {
//   const TabViewRoute2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     List tabs = ['新闻','历史','图片'];
//     return DefaultTabController(length: tabs.length, child: Scaffold(
//       appBar: AppBar(title: Text('TabBarView2'),
//         bottom: TabBar(tabs: tabs.map((e) => Tab(text: e,)).toList(),),
//       ),
//       body: TabBarView(
//         children: tabs.map((e) {
//           return Container(
//             alignment: Alignment.center,
//             child: Text(e, textScaleFactor: 5,),
//           );
//         }).toList(),
//       ),
//     ));
//   }
// }
//
//
// class TabViewRoute extends StatefulWidget {
//   const TabViewRoute({Key? key}) : super(key: key);
//
//   @override
//   _TabViewRouteState createState() => _TabViewRouteState();
// }
//
// class _TabViewRouteState extends State<TabViewRoute> with SingleTickerProviderStateMixin {
//
//   late TabController _tabController;
//
//   List tabs = ['新闻','历史','图片'];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(length: tabs.length, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('TabBarView'),
//         bottom: TabBar(controller: _tabController, tabs: tabs.map((e) => Tab(text: e,)).toList(),),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: tabs.map((e) {
//           return Container(
//             alignment: Alignment.center,
//             child: Text(e, textScaleFactor: 5,),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
// }

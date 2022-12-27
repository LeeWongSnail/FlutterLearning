
// class PersistentHeaderRoute extends StatelessWidget {
//   const PersistentHeaderRoute({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sliver PersistentHeader'),),
//       body: CustomScrollView(
//         slivers: [
//           buildSliverList(),
//           SliverPersistentHeader(pinned: true, delegate: SliverHeaderDelegate(maxHeight: 80, minHeight: 50, child: buildHeader(1))),
//           buildSliverList(),
//           SliverPersistentHeader(pinned: true, delegate: SliverHeaderDelegate.fixHeight(height: 50, child: buildHeader(2))),
//           buildSliverList(20)
//         ],
//       ),
//     );
//   }
//
//   Widget buildSliverList([int count = 5]) {
//     return SliverFixedExtentList(delegate: SliverChildBuilderDelegate((context, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 50), itemExtent: 50, );
//   }
//
//   Widget buildHeader(int i) {
//     return Container(
//       color: Colors.lightBlue.shade100,
//       alignment: Alignment.centerLeft,
//       child: Text('PersistentHeader $i'),
//     );
//   }
// }
//
//
// typedef SliverHeaderBuilder = Widget Function(BuildContext context, double shrinkOffset, bool overlapContent);
//
// class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
//
//   final double maxHeight;
//   final double minHeight;
//   final SliverHeaderBuilder builder;
//
//   SliverHeaderDelegate({
//     required this.maxHeight, this.minHeight = 0, required Widget child,
//   }) : builder = ((a, b, c) => child),
//         assert(minHeight <= maxHeight && minHeight >= 0);
//
//
//   SliverHeaderDelegate.fixHeight({
//     required double height,
//     required Widget child,
//   }) : builder = ((a,b,c) => child),
//         maxHeight = height,
//         minHeight = height;
//
//   SliverHeaderDelegate.builder({
//     required this.maxHeight,
//     this.minHeight = 0,
//     required this.builder,
//   });
//
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     // TODO: implement build
//     Widget child = builder(context, shrinkOffset, overlapsContent);
//     assert(() {
//       if(child.key != null) {
//         print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
//       }
//       return true;
//     }());
//     return SizedBox.expand(child: child,);
//   }
//
//   @override
//   // TODO: implement maxExtent
//   double get maxExtent => maxHeight;
//   @override
//   // TODO: implement minExtent
//   double get minExtent => minHeight;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     // TODO: implement shouldRebuild
//     return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
//   }
// }
//
//
// class CustomScrollViewWidget extends StatefulWidget {
//   const CustomScrollViewWidget({Key? key}) : super(key: key);
//
//   @override
//   _CustomScrollViewWidgetState createState() => _CustomScrollViewWidgetState();
// }
//
// class _CustomScrollViewWidgetState extends State<CustomScrollViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: CustomScrollView(slivers: [
//         // SliverToBoxAdapter(
//         //   child: SizedBox(height: 300,child: PageView(
//         //     children: [Text('1'),Text('2')],
//         //   ),),
//         // ),
//         SliverAppBar(pinned: true,expandedHeight: 250.0,
//           flexibleSpace: FlexibleSpaceBar(title: Text('SliverAppBar'), background: Image.asset("/Users/LeeWong/StudioProjects/flutter_ui/images/light.png", fit: BoxFit.cover,),),),
//         SliverPadding(padding: EdgeInsets.all(8.0), sliver: SliverGrid(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0, childAspectRatio: 4.0),
//           delegate: SliverChildBuilderDelegate((BuildContext context, int index){
//             return Container(alignment: Alignment.center, color: Colors.cyan[100*(index%9)], child: Text('gridItem $index'),);
//           }, childCount: 20),
//         ),),
//         SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//             return Container(
//               alignment: Alignment.center, color: Colors.lightBlue[100*index%9],child: Text('list item $index'),
//             );
//           },
//           childCount: 20,
//         ), itemExtent: 50.0)
//       ],),
//     );
//   }
// }


//
// class CustomScrollView extends StatefulWidget {
//   const CustomScrollView({Key? key}) : super(key: key);
//
//   @override
//   _CustomScrollViewState createState() => _CustomScrollViewState();
// }
//
// class _CustomScrollViewState extends State<CustomScrollView> {
//   @override
//   Widget build(BuildContext context) {
//     var listView = ListView.builder(itemBuilder: (_, index) {
//       return ListTile(title: Text('${index}'),);
//     }, itemCount: 20,);
//     return Scaffold(
//       appBar: AppBar(title: Text('CustomScrollView'),),
//       body: Column(
//         children: [
//           Expanded(child: listView,),
//           Divider(color: Colors.grey,),
//           Expanded(child: listView)
//         ],
//       )
//     );
//   }
// }
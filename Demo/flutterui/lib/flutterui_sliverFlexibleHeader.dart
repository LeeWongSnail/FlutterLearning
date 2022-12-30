//
// class ExtraInfoBoxConstraints<T> extends BoxConstraints {
//   ExtraInfoBoxConstraints(this.extra, BoxConstraints constraints):
//         super(minWidth: constraints.minWidth, minHeight: constraints.minHeight,
//           maxWidth: constraints.maxWidth, maxHeight: constraints.maxHeight);
//
//   // 额外的信息
//   final T extra;
//
//   @override
//   bool operator ==(Object other) {
//     // TODO: implement ==
//     if (identical(this, other)) return true;
//     return other is ExtraInfoBoxConstraints && super == other && other.extra == extra;
//   }
//
//   @override
//   // TODO: implement hashCode
//   int get hashCode => hashValues(super.hashCode, extra);
// }
//
//
// class SliverFlexibleHeaderRoute extends StatelessWidget {
//   const SliverFlexibleHeaderRoute({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SliverFlexibleHeader'),
//       ),
//       body: CustomScrollView(
//         // 为了能使CustomScrollView拉到顶部时还能继续下拉，必须让physics支持弹性效果
//         physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//         slivers: [
//           SliverFlexibleHeader(
//             visibleExtent: 200,
//             builder: (context, availableHeight, scrollDirection) {
//               return GestureDetector(
//                 onTap: () => print('tap'),
//                 child: Image(
//                   image: AssetImage("/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp"),
//                   width: 50,
//                   height: availableHeight,
//                   alignment: Alignment.bottomCenter,
//                   fit: BoxFit.cover,
//                 ),
//               );
//             },
//           ),
//           buildSliverList(),
//         ],
//       ),
//     );
//   }
//
//   Widget buildSliverList() {
//     var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
//       return ListTile(title: Text('$index'),);
//     }, childCount: 50), itemExtent: 56);
//     return listView;
//   }
// }
//
// typedef SliverFlexibleHeaderBuilder = Widget Function(BuildContext context, double maxExtent,  ScrollDirection direction); //,
//
// class SliverFlexibleHeader extends StatelessWidget {
//   const SliverFlexibleHeader({Key? key, this.visibleExtent = 0, required this.builder}) : super(key: key);
//
//   final SliverFlexibleHeaderBuilder builder;
//   final double visibleExtent;
//
//   @override
//   Widget build(BuildContext context) {
//     return _SliverFlexibleHeader(child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
//       return builder(context, constraints.maxHeight, (constraints as ExtraInfoBoxConstraints<ScrollDirection>).extra);
//     },), visibleExtent: visibleExtent,);
//   }
// }
//
//
// class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
//   const _SliverFlexibleHeader({Key? key, required Widget child, this.visibleExtent = 0}) : super(key: key, child: child);
//
//   final double visibleExtent;
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     // TODO: implement createRenderObject
//     return  FlexibleHeaderRenderSliver(visibleExtent);
//   }
//
//   @override
//   void updateRenderObject(BuildContext context, covariant FlexibleHeaderRenderSliver renderObject) {
//     // TODO: implement updateRenderObject
//     renderObject._visibleExtent = visibleExtent;
//   }
// }
//
// class FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
//   FlexibleHeaderRenderSliver(double visibleExtent) : _visibleExtent = visibleExtent;
//
//   double _lastOverScroll = 0;
//   double _lastScrollOffset = 0;
//   late double _visibleExtent = 0;
//   late ScrollDirection _direction;
//
//   set visibleExtent(double value) {
//     if(_visibleExtent != value) {
//       _lastOverScroll = 0;
//       _visibleExtent = value;
//       markNeedsLayout();
//     }
//   }
//
//   @override
//   void performLayout() {
//     // TODO: implement performLayout
//     if(child == null || (constraints.scrollOffset > _visibleExtent)) {
//       geometry = SliverGeometry(scrollExtent: _visibleExtent);
//       return;
//     }
//
//     double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
//     var scrollOffset = constraints.scrollOffset;
//     _direction = ScrollDirection.idle;
//
//     var distance = overScroll > 0 ? overScroll - _lastOverScroll : _lastScrollOffset - scrollOffset;
//     _lastOverScroll = overScroll;
//     _lastScrollOffset = scrollOffset;
//
//     if(constraints.userScrollDirection == ScrollDirection.idle) {
//       _direction = ScrollDirection.idle;
//       _lastOverScroll = 0;
//     } else if(distance > 0) {
//       _direction = ScrollDirection.forward;
//     } else if (distance < 0) {
//       _direction = ScrollDirection.reverse;
//     }
//
//
//     double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
//     paintExtent = min(paintExtent, constraints.remainingPaintExtent);
//
//     // child!.layout(constraints.asBoxConstraints(maxExtent: paintExtent), parentUsesSize: false);
//
//     child!.layout(
//       ExtraInfoBoxConstraints(_direction, constraints.asBoxConstraints(maxExtent: paintExtent)),
//       parentUsesSize: false,
//     );
//
//     double layoutExtent = min(_visibleExtent, paintExtent);
//
//     geometry = SliverGeometry(
//         scrollExtent: layoutExtent,
//         paintOrigin: -overScroll,
//         paintExtent: paintExtent,
//         maxPaintExtent: paintExtent,
//         layoutExtent: layoutExtent
//     );
//   }
// }
//

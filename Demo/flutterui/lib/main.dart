import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SliverFlexibleHeaderRoute(),
    );
  }
}


class SliverFlexibleHeaderRoute extends StatelessWidget {
  const SliverFlexibleHeaderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverFlexibleHeader'),
      ),
      body: CustomScrollView(
        // 为了能使CustomScrollView拉到顶部时还能继续下拉，必须让physics支持弹性效果
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverFlexibleHeader(
            visibleExtent: 200,
            builder: (context, availableHeight) {
              return GestureDetector(
                onTap: () => print('tap'),
                child: Image(
                  image: AssetImage("/Users/leewong/Documents/Code/Flutter/Project/FlutterLearning/Demo/flutterui/images/icon.webp"),
                  width: 50,
                  height: availableHeight,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          buildSliverList(),
        ],
      ),
    );
  }

  Widget buildSliverList() {
    var listView = SliverFixedExtentList(delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'),);
    }, childCount: 50), itemExtent: 56);
    return listView;
  }
}

typedef SliverFlexibleHeaderBuilder = Widget Function(BuildContext context, double maxExtent); //, ScrollDirection direction

class SliverFlexibleHeader extends StatelessWidget {
  const SliverFlexibleHeader({Key? key, this.visibleExtent = 0, required this.builder}) : super(key: key);

  final SliverFlexibleHeaderBuilder builder;
  final double visibleExtent;

  @override
  Widget build(BuildContext context) {
    return _SliverFlexibleHeader(child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return builder(context, constraints.maxHeight);
    },), visibleExtent: visibleExtent,);
  }
}


class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
  const _SliverFlexibleHeader({Key? key, required Widget child, this.visibleExtent = 0}) : super(key: key, child: child);

  final double visibleExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return  FlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(BuildContext context, covariant FlexibleHeaderRenderSliver renderObject) {
    // TODO: implement updateRenderObject
    renderObject._visibleExtent = visibleExtent;
  }
}

class FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  FlexibleHeaderRenderSliver(double visibleExtent) : _visibleExtent = visibleExtent;

  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  late double _visibleExtent = 0;

  set visibleExtent(double value) {
    if(_visibleExtent != value) {
      _lastOverScroll = 0;
      _visibleExtent = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    // TODO: implement performLayout
    if(child == null || (constraints.scrollOffset > _visibleExtent)) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    var scrollOffset = constraints.scrollOffset;

    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);

    child!.layout(constraints.asBoxConstraints(maxExtent: paintExtent), parentUsesSize: false);

    double layoutExtent = min(_visibleExtent, paintExtent);

    geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintOrigin: -overScroll,
        paintExtent: paintExtent,
        maxPaintExtent: paintExtent,
        layoutExtent: layoutExtent
    );
  }
}




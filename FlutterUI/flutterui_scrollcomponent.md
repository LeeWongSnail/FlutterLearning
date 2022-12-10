# 可滚动组件简介

这篇文章是可滚动组件的一个介绍，内部提到的一些概念在本篇文章中可能不会详细的介绍，但是在后续的文章中都会一一解答。阅读本篇文章的主要目的是让我们了解可滚动组件到底是什么，由那几部分组成，有哪些好用的功能可以使用。

## Sliver布局

我们前面提到过Flutter有两种布局模型:

- 基于RenderBox的盒模型布局
- 基于Sliver(RenderSliver)按需加载列表布局

Sliver 的主要作用是配合：`加载子组件并确定每一个子组件的布局和绘制信息，如果 Sliver 可以包含多个子组件时，通常会实现按需加载模型`.

Flutter 中的可滚动主要由三个角色组成：`Scrollable`、`Viewport` 和 `Sliver`：

- Scrollable ：用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建 Viewport  类似iOS中的scrollView
- Viewport：显示的视窗，即列表的可视区域；类似VisibleRect
- Sliver：视窗里显示的元素。类似visibleCells

具体的布局过程为：

- Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport 。
- Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver。
- Sliver 中对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，保存在 geometry 中（一个 SliverGeometry 类型的对象）。

我们来看下下面这种图片，来更好的了解三者之间的关系:

![flutterui_listviewframework](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_listviewframework.png)

图中白色区域为设备屏幕，也是上述三者所占用的控件
- 父子关系，从父子关系来讲 sliver的父组件是viewPort, viewPort的父组件是scrollable
- cacheExtent 表示预渲染的高度

## scrollable

用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建Viewport,


下面我们来看下关键的属性

```dart
Scrollable({
  ...
  this.axisDirection = AxisDirection.down,
  this.controller,
  this.physics,
  required this.viewportBuilder, //后面介绍
})
```

- axisDirection 表示滚动方向
- physics 决定可滚动组件如何响应用户操作。flutter会根据具体平台分别使用不同的ScrollPhysics对象。
- controller 此属性是一个ScrollController对象，主要用于控制滚动位置和监听滚动事件。
- viewPortBuilder 构建viewPort的回调，当用户滚动屏幕时，scrollable会调用次回调构建新的viewport,同时传递一个viewportOffset类型的offset参数，该参数描述viewport应该显示那一部分内容。


## 主轴和纵轴

通常滚动方向为主轴，非滚动方向为纵轴，一般可滚动组件默认都是垂直方向滚动，因此一般默认主轴都是垂直方向，纵轴都是水平方向

## viewport

```dart
Viewport({
  Key? key,
  this.axisDirection = AxisDirection.down,
  this.crossAxisDirection,
  this.anchor = 0.0,
  required ViewportOffset offset, // 用户的滚动偏移
  // 类型为Key，表示从什么地方开始绘制，默认是第一个元素
  this.center,
  this.cacheExtent, // 预渲染区域
  //该参数用于配合解释cacheExtent的含义，也可以为主轴长度的乘数
  this.cacheExtentStyle = CacheExtentStyle.pixel, 
  this.clipBehavior = Clip.hardEdge,
  List<Widget> slivers = const <Widget>[], // 需要显示的 Sliver 列表
})
```

viewport用于渲染当前窗口中需要展示的sliver

- offset scrollable构建viewport时传入，描述viewport应该展示哪一部分内容。
- cahceExtent和cacheExtentStyle： CacheExtentStyle是一个枚举，有pixel何viewPort两个取值。
   - 当cacheExtentStyle为pixel时，cacheExtent的值为与渲染区域的具体像素长度
   - 当cacheExtentStyle为viewport时，cacheExtent的值是一个乘数，表示有几个viewport的长度，最终的渲染区域	 的像素长度为cacheExtent*viewport的积。表示按页面缓存，这对于灭一个列表都沾满一个viewPort的时候比较实用。

## Sliver

主要作用是对子组件进行构建和布局，比如 ListView 的 Sliver 需要实现子组件（列表项）按需加载功能，只有当列表项进入预渲染区域时才会去对它进行构建和布局、渲染。

## scrollController

可滚动组件都有一个 controller 属性，通过该属性我们可以指定一个 ScrollController 来控制可滚动组件的滚动，比如可以通过ScrollController来同步多个组件的滑动联动。

## 子节点缓存

一般情况我们都是按需加载，当视图离开屏幕渲染区域时就会被释放，重新展示的时候回重新构建。当然这个机制也是可以我们控制的，具体方法我们后续在详细了解。


# 图片展示

![flutterui_image](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui-image.png)

## 本地图片

### 添加本地图片资源

- 在项目的根目录下新建图片资源文件文件夹 images

![flutterui_addlocalimage](https://github.com/LeeWongSnail/FlutterLearning/raw/main/res/flutterui_addlocalimage.png)

`注意`:这里不区分2x和3x图，因为在使用中都是直接使用文件名(包含.png)

- 在pubspec.yaml文件中配置图片资源

```dart
flutter:
  assets:
    - images/
```

`注意`: 配置一定要加载flutter下面，同时对于路径可以配置图片资源的绝对路径也可以配置图片资源的目录，上述示例为配置图片资源的目录


- 项目中使用

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
      Image(image: AssetImage('images/watermark_remove@2x.png'), width: 50,),
      Image.asset('images/watermark_remove@3x.png',width: 80,),
  		],
),
```

## 网络图片

```dart
Row(
   mainAxisAlignment: MainAxisAlignment.center,
   children: [
      Image(image: NetworkImage(''), width: 50),
      Image.network('', width: 50,),
    ],
),
```

## 图片宽高

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image(image: NetworkImage(''),
      width: 100, height: 60,
    ),
    Image(image: NetworkImage(''),
      width: 100,
    ),
  ],
),
```

- 如果既设置了宽度也设置了高度 则根据设置的填充模式展示图片
- 如果设置了宽度或者高度 则设置的一方根据设置的值来 另一个自动缩放
- 如果宽高都没有设置，则图片在容器视图中尽可能的显示器原始大小


## 图片展示模式

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image(image: NetworkImage(''),
      width: 100, height: 60,
      fit: BoxFit.fitHeight,
    ),
    Image(image: NetworkImage(''),
      width: 100, height: 60,
      fit: BoxFit.fitWidth,
    ),
  ],
),
```
图片填充模式可以有一下几种

- fill 会拉伸填充满显示空间，图片本身`长宽比会发生变化`，`图片会变形`
- cover 会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分`会被剪裁`。
- contain  这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下`缩放以适应当前显示空间，图片不会变形`。
- fitWidth 图片的`宽度`会`缩放到显示空间的宽度`，`高度`会`按比例缩放`，然后`居中`显示，图片`不会变形`，超出显示空间部分会`被剪裁`。
- fitHeight 图片的`高度`会`缩放`到显示空间的高度，`宽度`会按`比例缩放`，然后`居中`显示，图片`不会变形`，超出显示空间部分会被`剪裁`。
- none 图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。

## 图片颜色混合

在图片绘制时可以对每一个像素进行颜色混合处理

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image(image: NetworkImage(''),
      width: 100, height: 60,
      color: Colors.red,
      colorBlendMode: BlendMode.color,
    ),
  ],
),
```
- color指定混合色，
- colorBlendMode指定混合模式 具体模式可以看api

## repeat

当图片本身大小小于显示空间时，指定图片的重复规则

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image(image: NetworkImage(''),
      width: 100, height: 60,
      repeat: ImageRepeat.repeatX,
    ),
    Image(image: NetworkImage(''),
      width: 100, height: 60,
      repeat: ImageRepeat.repeatY,
    ),
  ],
),
```

- repeat x&y均 repeat
- repeatX 仅x repeat
- repeatY 仅y repeat
- noRepeat 不需要repeat


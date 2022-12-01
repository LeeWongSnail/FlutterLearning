# 按钮

![buttonExamplePic]()

## ElevatedButton

```dart
ElevatedButton(onPressed: (){
        print('点击了按钮');
}, child: Text('ElevatedButton'),
```

## TextButton

```dart
TextButton(onPressed: (){
  print('点击了TextButton');
}, child: Text('TextButton')),
```

## OutlineButton

```dart
OutlinedButton(onPressed: (){
  print('点击了OutlinedButton');
}, child: Text('OutlinedButton')),
```

## IconButton

```dart
IconButton(onPressed: (){
  print('点击了点赞按钮');
}, icon: Icon(Icons.thumb_up)),
IconButton(onPressed: (){
  print('点击了踩的按钮');
}, icon: Icon(Icons.thumb_down)),
```

## Text+Icon Button

```dart
ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.send), label: Text('ElevatedButton')),

TextButton.icon(onPressed: (){}, icon: Icon(Icons.add), label: Text('TextButton')),

OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.details), label: Text('OutlinedButton')),
```


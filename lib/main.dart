import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './flutterApp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: FlutterApp(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    Image image = new Image.network(
        'https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1564812422&di=a113f4b98d25442643ad9236f01ecbf5&src=http://hbimg.b0.upaiyun.com/0338cbe93580d5e6b0e89f25531541d455f66fda4a6a5-eVWQaf_fw658');
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image.resolve(new ImageConfiguration()).addListener(
        ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image)));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Image Dimensions Example"),
      ),
      body: new ListView(
        children: [
          new FutureBuilder<ui.Image>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
              if (snapshot.hasData) {
                return new Text(
                  '${snapshot.data.width}x${snapshot.data.height}',
                  style: Theme.of(context).textTheme.body2,
                );
              } else {
                return new Text('Loading...');
              }
            },
          ),
          image,
        ],
      ),
    );
  }
}

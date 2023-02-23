import 'dart:async';
import 'dart:developer';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_share/hi_share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('hi_share'),
        ),
        body: Center(
          child: InkWell(
            onTap: _doTap,
            child: const Text('调用方法'),
          ),
        ),
      ),
    );
  }

  void _doTap() async {
    var asset = AssetImage('res/event_icon.png');
    var image = await myloadImageByProvider(asset);
    var data = await image.toByteData(format: UI.ImageByteFormat.png);
    var uint8 = data?.buffer.asUint8List();

    var result = await HiShare().show(
      title: 'aabbccc',
      imageData: uint8!,
      urlString: 'https://www.youdao.com/result?word=foobar&lang=en',
    );
    log('result: $result');
  }
}

// https://www.jianshu.com/p/ffb4b58f0aa9/

// Future<UI.Image> loadImageByProvider(
//   ImageProvider provider, {
//   ImageConfiguration config = ImageConfiguration.empty,
// }) async {
//   Completer<UI.Image> completer = Completer<UI.Image>(); //完成的回调
//   ImageStream stream = provider.resolve(config); //获取图片流
//   ImageStreamListener listener =
//       ImageStreamListener((ImageInfo frame, bool sync) {
//     final UI.Image image = frame.image;
//     completer.complete(image); //完成
//     // stream.removeListener(listener); //移除监听
//   });
//   stream.addListener(listener); //添加监听
//   return completer.future; //返回
// }

Future<UI.Image> myloadImageByProvider(
  ImageProvider provider, {
  ImageConfiguration config = ImageConfiguration.empty,
}) async {
  Completer<UI.Image> completer = Completer<UI.Image>(); //完成的回调
  ImageStreamListener? listener;
  ImageStream stream = provider.resolve(config); //获取图片流
  listener = ImageStreamListener((ImageInfo frame, bool sync) {
//监听
    final UI.Image image = frame.image;
    completer.complete(image); //完成
    stream.removeListener(listener!); //移除监听
  });
  stream.addListener(listener); //添加监听
  return completer.future; //返回
}

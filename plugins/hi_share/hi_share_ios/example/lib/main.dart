import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hi_share_ios/hi_share_ios.dart';

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
          title: const Text('hi_share_ios'),
        ),
        body: Center(
          child: InkWell(
            child: Text('test'),
            onTap: _doTap,
          ),
        ),
      ),
    );
  }

  void _doTap() async {
    var result = await HiShareIOS().show();
    log('result: $result');
  }
}

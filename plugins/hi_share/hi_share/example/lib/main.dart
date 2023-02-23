import 'dart:developer';

import 'package:flutter/material.dart';
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
    var share = HiShare();
    var result = await share.show();
    log('result: $result');
  }
}

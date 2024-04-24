import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hi_config/hi_config.dart';

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
          title: const Text('hi_config'),
        ),
        body: Center(
          child: InkWell(
            onTap: _doTap,
            child: const Text('test'),
          ),
        ),
      ),
    );
  }

  void _doTap() async {
    var result = await HiConfig.shared().baseLink();
    log('result: $result');
  }
}

import 'package:example/plain.dart';
import 'package:flutter/material.dart';
import 'package:hi_flutter/hi_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String text = 'Made by https://cretezy.com yjx person@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: _doTap,
        child: Center(
          child: Linkify(
            text: text,
            style: TextStyle(color: Colors.black),
            linkStyle: TextStyle(color: Colors.red),
            linkifiers: [PlainLinkifier('yjx')],
            onOpen: (link) => log(link),
          ),
        ),
      ),
    );
  }

  void _doTap() {
    final match = RegExp('yjx').firstMatch(text);
    log('match: $match');
  }
}

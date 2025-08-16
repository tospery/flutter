import 'package:example/plan.dart';
import 'package:flutter/material.dart';
import 'package:hi_cache/hi_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiCache.ready();
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
  int _counter = 0;

  void _incrementCounter() async {
    // var aaa = json.decode('aaaa');
    // HiCache.shared().set('mystring', 123);
    // var result = HiCache.shared().get('mystring');
    // log('result = $result');
    // var aaa = Plan.fromJson;
    // var plan = Plan(id: 'idvalue', name: 'namevalue', space: 12);
    // await HiCache.shared().store('plan', model: plan);
    // var result = await HiCache.shared().fetch('plan', Plan.fromJson);
    // await HiCache.shared().storeObject(plan);
    // var result1 = await HiCache.shared().fetchObject(Plan.fromJson);
    // log('result1 = $result1');
    // await HiCache.shared().storeObject(plan, id: '111');
    // var result2 = await HiCache.shared().fetchObject(Plan.fromJson, id: '111');
    // log('result2 = $result2');
    //
    // var plan1 = Plan(id: 'id1', name: 'name1', space: 1);
    // var plan2 = Plan(id: 'id2', name: 'name2', space: 2);
    // await HiCache.shared().storeArray([plan1, plan2]);
    // await HiCache.shared().storeArray([plan1, plan2], page: 'page111');
    // var result3 = await HiCache.shared().fetchArray(Plan.fromJson, page: 'page111');
    // log('result3 = $result3');

    var plan1 = const Plan(id: 'aaa', space: 111);
    // await HiCache.shared().storeObject(plan1);
    // var myPlan1SP = await HiCache.shared().fetchObject(Plan.fromJson);
    // log('myPlan1SP: $myPlan1SP');
    // await HiCache.shared().storeObject(plan1, useDatabase: true);
    // var myPlan1DB = await HiCache.shared().fetchObject(Plan.fromJson, useDatabase: true);
    // log('myPlan1DB: $myPlan1DB');
    // await HiCache.shared().storeObject(plan1, useDatabase: true, id: 'a1');
    // var myPlan1DBa1 = await HiCache.shared().fetchObject(Plan.fromJson, useDatabase: true, id: 'a1');
    // log('myPlan1DBa1: $myPlan1DBa1');

    var plan2 = const Plan(id: 'bbb', space: 222);
    await HiCache.shared().storeArray([plan1, plan2]);
    var my1 = await HiCache.shared().fetchArray(Plan.fromJson);
    log('my1: $my1');
    await HiCache.shared().storeArray([plan1, plan2], page: 'b2');
    var my2 = await HiCache.shared().fetchArray(Plan.fromJson, page: 'b2');
    log('my2: $my2');
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

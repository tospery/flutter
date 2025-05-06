import 'package:flutter/material.dart';
import 'log_panel.dart';

class CasePage extends StatefulWidget {
  const CasePage({
    super.key,
    required this.title,
    required this.body,
    this.padding = false,
    this.showLog = false,
  });

  final String title;
  final Widget body;
  final bool padding;
  final bool showLog;

  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  late bool _showLog;

  @override
  void initState() {
    _showLog = widget.showLog;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CasePage oldWidget) {
    if (oldWidget.showLog != widget.showLog) {
      _showLog = widget.showLog;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showLog = !_showLog;
              });
            },
            icon: const Icon(Icons.print),
          ),
        ],
      ),
      body: VerticalLogPanel(showLogPanel: _showLog, child: wBody()),
    );
  }

  wBody() {
    return widget.padding
        ? Padding(padding: const EdgeInsets.all(16.0), child: widget.body)
        : widget.body;
  }
}

class Case {
  Case(
    this.title,
    Widget child, {
    this.withScaffold = true,
    this.padding = true,
    this.showLog = false,
  }) : builder = ((_) => child);

  Case.builder(
    this.title,
    this.builder, {
    this.withScaffold = true,
    this.padding = true,
    this.showLog = false,
  });

  String title;
  WidgetBuilder builder;
  bool withScaffold;
  bool padding;
  bool showLog;

  Widget build(BuildContext context) {
    Widget widget = builder(context);
    if (withScaffold) {
      widget = CasePage(
        title: title,
        padding: padding,
        showLog: showLog,
        body: widget,
      );
      widget = LogListenerScope(
        logEmitter: getGlobalLogEmitter(),
        child: widget,
      );
    } else if (showLog) {
      widget = VerticalLogPanel(child: widget);
      widget = LogListenerScope(
        logEmitter: getGlobalLogEmitter(),
        child: widget,
      );
    }
    return widget;
  }

  Future<T?> openCase<T>(BuildContext context) {
    return Navigator.push<T>(context, MaterialPageRoute<T>(builder: build));
  }
}

class ListCase extends StatelessWidget {
  const ListCase({super.key, required this.children});

  final List<Case> children;

  @override
  Widget build(BuildContext context) {
    return ListView(children: _generateItem(context));
  }

  List<Widget> _generateItem(BuildContext context) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openCase(context),
      );
    }).toList();
  }
}

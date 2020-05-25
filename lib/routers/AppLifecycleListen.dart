import 'package:flutter/material.dart';

class AppLifecycleListen extends StatefulWidget {
  @override
  _AppLifecycleListenState createState() => _AppLifecycleListenState();
}

class _AppLifecycleListenState extends State<AppLifecycleListen>
    with WidgetsBindingObserver {
  List<String> _stateList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _stateList.add('$state');
    });
  }

  Widget get _widget {
    if (_stateList.isEmpty) {
      return Center(
        child: Text(
          '将App切换到后台再返回App',
          style: Theme.of(context).textTheme.headline5,
        ),
      );
    }
    return ListView(
      children: _stateList
          .map((String value) => ListTile(
                title: Text(value, style: TextStyle(fontSize: 18.0)),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('App状态监听'),
      ),
      body: _widget,
    );
  }
}

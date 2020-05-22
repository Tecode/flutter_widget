import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLifecycleListen extends StatefulWidget {
  @override
  _AppLifecycleListenState createState() => _AppLifecycleListenState();
}

class _AppLifecycleListenState extends State<AppLifecycleListen> {
  List<String> _stateList = [];
  @override
  void initState() {
    super.initState();
    SystemChannels.lifecycle.setMessageHandler((value) {
      print(value);
      setState(() {
        _stateList.add(value);
      });
      return;
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

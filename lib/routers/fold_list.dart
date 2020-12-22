import 'package:flutter/material.dart';

class FoldList extends StatefulWidget {
  @override
  _FoldListState createState() => _FoldListState();
}

class _FoldListState extends State<FoldList> {
  double _height = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            ScrollMetrics metrics = notification.metrics;
            return true;
          },
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              if (index == 4) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOutCirc,
                  margin: EdgeInsets.symmetric(horizontal: 15.0).copyWith(
                    bottom: 10.0,
                  ),
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  height: _height,
                  child: IconButton(
                    onPressed: () => this
                        .setState(() => _height = _height == 200 ? 40 : 200),
                    icon: Icon(_height == 200
                        ? Icons.arrow_circle_up_outlined
                        : Icons.arrow_circle_down_rounded),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0).copyWith(
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(color: Colors.black12),
                height: 40.0,
              );
            },
          ),
        ),
      ),
    );
  }
}

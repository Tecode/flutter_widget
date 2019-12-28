import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import "package:flare_flutter/flare_cache_builder.dart";

class Animationted extends StatefulWidget {
  @override
  _AnimationtedState createState() => _AnimationtedState();
}

class _AnimationtedState extends State<Animationted> {
  String _animationName = "animation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
      ),
      body: FlareCacheBuilder(
        ["assets/animation.flr"],
        builder: (BuildContext context, bool isWarm) {
          return !isWarm
              ? Container(child: Text("NO"))
              : FlareActor(
                  "assets/animation.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: _animationName,
                );
        },
      ),
    );
  }
}

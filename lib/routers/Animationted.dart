import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import "package:flare_flutter/flare_cache_builder.dart";
import 'package:flutter/services.dart';

class Animationted extends StatefulWidget {
  @override
  _AnimationtedState createState() => _AnimationtedState();
}

class _AnimationtedState extends State<Animationted> {
  String _animationName = "idle";
  final asset = AssetFlare(bundle: rootBundle, name: "assets/Filip.flr");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
      ),
      body: FlareCacheBuilder(
        [asset],
        builder: (BuildContext context, bool isWarm) {
          return !isWarm
              ? Container(child: Text("NO"))
              : FlareActor(
                  "assets/Filip.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  animation: _animationName,
                );
        },
      ),
    );
  }
}

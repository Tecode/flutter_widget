import 'package:flutter/material.dart';
import 'package:flutter_widget/routers/LoginVideo.dart';
import 'package:flutter_widget/routers/UnlimitedHighCarousel.dart';
import 'package:flutter_widget/routers/AudioApp.dart';
import 'package:flutter_widget/routers/SlideDown.dart';
import 'package:flutter_widget/routers/TabBarFixed.dart';
import 'package:flutter_widget/routers/StickTab.dart';
import 'package:flutter_widget/routers/PlatformChannel.dart';

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Color(0xfffafafa),
        padding: EdgeInsets.only(top: 28.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("视频背景登录"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginVideo()));
              },
            ),
            ListTile(
              title: Text("仿马蜂窝不限高轮播图"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UnlimitedHighCarousel()));
              },
            ),
            ListTile(
              title: Text("下拉菜单"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SlideDown()));
              },
            ),
            ListTile(
              title: Text("音频播放"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AudioApp()));
              },
            ),
            ListTile(
              title: Text("固定TabBar"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TabBarFixed()));
              },
            ),
            ListTile(
              title: Text("ListView嵌套ListView"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StickTab()));
              },
            ),
            ListTile(
              title: Text("平台通道"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PlatformChannel()));
              },
            ),
          ],
        ),
      ),
    ));
  }
}

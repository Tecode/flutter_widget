import 'package:flutter/material.dart';
import 'package:flutter_widget/routers/AppLifecycleListen.dart';
import 'package:flutter_widget/routers/CollapseNavigation.dart';
import 'package:flutter_widget/routers/LoginVideo.dart';
import 'package:flutter_widget/routers/StackNavBar.dart';
import 'package:flutter_widget/routers/Swiper.dart';
import 'package:flutter_widget/routers/UnlimitedHighCarousel.dart';
import 'package:flutter_widget/routers/AudioApp.dart';
import 'package:flutter_widget/routers/SlideDown.dart';
import 'package:flutter_widget/routers/TabBarFixed.dart';
import 'package:flutter_widget/routers/StickTab.dart';
import 'package:flutter_widget/routers/PlatformChannel.dart';
import 'package:flutter_widget/routers/Animationted.dart';
import 'package:flutter_widget/routers/VideoPictureInPicture.dart';
import 'package:flutter_widget/routers/carousel_zoom.dart';

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Color(0xfffafafa),
        padding: EdgeInsets.only(top: 28.0),
        child: ListView(
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
              title: Text("具有缩放效果的轮播图"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CarouselZoom()));
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
            ListTile(
              title: Text("动画"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Animationted()));
              },
            ),
            ListTile(
              title: Text("Swipe"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Swipe()));
              },
            ),
            ListTile(
              title: Text("滑动导航变色"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StackNavBar()));
              },
            ),
            ListTile(
              title: Text("滑动隐藏导航"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CollapseNavigation()));
              },
            ),
            ListTile(
              title: Text("App状态监听"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppLifecycleListen()));
              },
            ),
            ListTile(
              title: Text("视频嵌套播放"),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPictureInPicture()));
              },
            ),
          ],
        ),
      ),
    ));
  }
}

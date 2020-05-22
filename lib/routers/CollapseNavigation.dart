import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CollapseNavigation extends StatefulWidget {
  CollapseNavigation({Key key}) : super(key: key);

  @override
  _CollapseNavigationState createState() => _CollapseNavigationState();
}

class _CollapseNavigationState extends State<CollapseNavigation> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 0,
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.black87),
                  onPressed: () {},
                ),
              ],
              title: Container(
                height: 30.0,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.circular(40.0)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '搜索：Flutter 小组件',
                    style: TextStyle(fontSize: 14.0, color: Colors.black38),
                  ),
                ),
              ),
            ),
//            SliverPersistentHeader(
//              pinned: true,
//              delegate: _SliverAppBarDelegate(
//                minHeight: 60.0,
//                maxHeight: 180.0,
//                child: ListView(
//                  scrollDirection: Axis.horizontal,
//                  children: [],
//                ),
//              ),
//            ),
            SliverFixedExtentList(
                itemExtent: 100.0,
                delegate: SliverChildListDelegate(
                  List.generate(
                    60,
                    (int index) => ListTile(
                        title:
                            Text('Flutter ${(index + 10).toRadixString(2)}')),
                  ).toList(),
                )),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

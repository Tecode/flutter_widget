import 'dart:math';

import 'package:flutter/material.dart';

class CollapseNavigation extends StatefulWidget {
  CollapseNavigation({Key key}) : super(key: key);

  @override
  _CollapseNavigationState createState() => _CollapseNavigationState();
}

class _CollapseNavigationState extends State<CollapseNavigation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background(image: 'assets/images/fondo_horario.webp'),
        Container(
          color: Colors.black.withOpacity(.3),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                title: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "HORARIO DE CURSOS DEL CICLO 2019B",
                        style:
                            TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "TOTAL DE CRÉDITOS: 52",
                        style:
                            TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 60.0,
                  maxHeight: 180.0,
                  child: Container(),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Text('dara'),
              // )
            ],
          ),
        ),
      ],
    );
    ;
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

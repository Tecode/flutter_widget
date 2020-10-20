import 'dart:math' as math;
import 'package:flutter/material.dart';

const _horizontalPadding = 32.0;
const _carouselItemMargin = 8.0;
const _horizontalDesktopPadding = 81.0;
const _carouselHeightMin = 200.0 + 2 * _carouselItemMargin;
const _desktopCardsPerPage = 4;

class CarouselZoom extends StatefulWidget {
  const CarouselZoom();
  @override
  _CarouselZoomState createState() => _CarouselZoomState();
}

class _CarouselZoomState extends State<CarouselZoom>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Carousel(
        children: <Widget>[
          Container(
            color: Colors.green,
            width: MediaQuery.of(context).size.width - 60,
            height: 160.0,
          ),
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width - 60,
            height: 160.0,
          ),
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width - 60,
            height: 160.0,
          ),
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width - 60,
            height: 160.0,
          ),
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width - 60,
            height: 160.0,
          ),
          Container(
            color: Colors.blue,
            width: MediaQuery.of(context).size.width - 60,
            height: 160.0,
          ),
        ],
        animationController: _animationController,
      ),
    );
  }
}

class _Carousel extends StatefulWidget {
  const _Carousel({
    Key key,
    this.children,
    this.animationController,
  }) : super(key: key);

  final List<Widget> children;
  final AnimationController animationController;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel>
    with SingleTickerProviderStateMixin {
  PageController _controller;
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller == null) {
      // The viewPortFraction is calculated as the width of the device minus the
      // padding.
      final width = MediaQuery.of(context).size.width;
      final padding = (_horizontalPadding * 2) - (_carouselItemMargin * 2);
      _controller = PageController(
        initialPage: _currentPage,
        viewportFraction: (width - padding) / width,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget builder(int index) {
    final carouselCard = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value;
        if (_controller.position.haveDimensions) {
          value = _controller.page - index;
        } else {
          // If haveDimensions is false, use _currentPage to calculate value.
          value = (_currentPage - index).toDouble();
        }
        // We want the peeking cards to be 160 in height and 0.38 helps
        // achieve that.
        value = (1 - (value.abs() * .38)).clamp(0, 1).toDouble();
        value = Curves.easeOut.transform(value);

        return Center(
          child: Transform(
            transform: Matrix4.diagonal3Values(1.0, value, 1.0),
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: widget.children[index],
    );
    return carouselCard;
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedCarousel(
      child: PageView.builder(
        // Makes integration tests possible.
        key: const ValueKey('studyDemoList'),
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        controller: _controller,
        itemCount: widget.children.length,
        itemBuilder: (context, index) => builder(index),
        allowImplicitScrolling: true,
      ),
      controller: widget.animationController,
    );
  }
}

double _carouselHeight(double scaleFactor, BuildContext context) => math.max(
    _carouselHeightMin * MediaQuery.of(context).textScaleFactor * scaleFactor,
    _carouselHeightMin);

class _AnimatedCarousel extends StatelessWidget {
  _AnimatedCarousel({
    Key key,
    @required this.child,
    @required this.controller,
  })  : startPositionAnimation = Tween(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.200,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPositionAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return child;
        },
        child: Container(
          height: _carouselHeight(.4, context),
          width: constraints.maxWidth,
          child: child,
        ),
      );
    });
  }
}

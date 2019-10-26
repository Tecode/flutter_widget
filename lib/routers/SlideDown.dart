import 'package:flutter/material.dart';
import 'package:flutter_widget/helpers/flutter_toast.dart';

class SlideDown extends StatefulWidget {
  const SlideDown();
  @override
  _SlideDownState createState() => _SlideDownState();
}

class _SlideDownState extends State<SlideDown> with TickerProviderStateMixin {
  AnimationController _animation;
  final opacityTween = Tween(begin: 0.0, end: 1.0);
  final positionTween = Tween(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  );
  bool _visible = false;

  CurvedAnimation _curve;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _curve = CurvedAnimation(
      parent: _animation,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.decelerate,
    );
    _animation.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.adjust),
          onPressed: () {
            FlutterToast.showToast('msg');
            if (_visible) {
              this.setState(() {
                _visible = false;
              });
              _animation.reverse();
              return;
            }
            this.setState(() {
              _visible = true;
            });
            _animation.forward();
          },
        ),
      ),
      body: Stack(
        overflow: Overflow.clip,
        children: <Widget>[
          Align(
            child: RaisedButton(
              onPressed: () {
                if (_visible) {
                  this.setState(() {
                    _visible = false;
                  });
                  _animation.reverse();
                  return;
                }
                this.setState(() {
                  _visible = true;
                });
                _animation.forward();
              },
              child: Text("点我"),
            ),
          ),
          Positioned(
            child: FadeTransition(
              opacity: opacityTween.animate(_curve),
              child: GestureDetector(
                onTap: () {
                  _animation.reverse();
                  this.setState(() {
                    _visible = false;
                  });
                },
                child: Visibility(
                  visible: _visible,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: FadeTransition(
              opacity: opacityTween.animate(_curve),
              child: SlideTransition(
                position: positionTween.animate(_curve),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

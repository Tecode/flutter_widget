import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPictureInPicture extends StatefulWidget {
  @override
  _VideoPictureInPictureState createState() => _VideoPictureInPictureState();
}

class _VideoPictureInPictureState extends State<VideoPictureInPicture> {
  VideoPlayerController _controller01;
  PageController _pageController = PageController(initialPage: 0);
  final String videoUrl01 =
      'https://video.pearvideo.com/mp4/third/20200515/cont-1674768-12719568-193822-hd.mp4';
  bool _toggle = false;

  @override
  void initState() {
    super.initState();
    _controller01 = VideoPlayerController.network(videoUrl01);
    _controller01.addListener(() {
      print(_controller01.value);
    });
//    _pageController.nextPage(
//      duration: Duration(milliseconds: 400),
//      curve: Curves.easeOut,
//    );
  }

  @override
  void dispose() {
    _controller01.dispose();
    super.dispose();
  }

  Widget get _widget01 {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(_controller01),
    );
  }

  Widget get _widget02 {
    return Container(
      color: Colors.deepOrange,
      child: PageView.builder(
        controller: _pageController,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            Image.asset('picture/ppt/幻灯片${index + 1}.png'),
        itemCount: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([_controller01.initialize()]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _controller01.play();
            return Stack(
              children: <Widget>[
                Visibility(
                  visible: _toggle,
                  child: _widget01,
                ),
                Visibility(
                  visible: _toggle,
                  child: _widget02,
                ),
                Positioned(
                  width: 200.0,
                  height: 112.5,
                  bottom: 10.0,
                  right: 10.0,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _toggle = !_toggle;
                    }),
                    child: _toggle ? _widget02 : _widget01,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text(
              '视频加载中',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        },
      ),
    );
  }
}

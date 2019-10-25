import 'package:flutter/material.dart';

class PictrueData extends Object {
  final double width;
  final double height;
  final String url;

  PictrueData({this.width, this.height, this.url});
}

class UnlimitedHighCarousel extends StatefulWidget {
  const UnlimitedHighCarousel();

  @override
  _UnlimitedHighCarouselState createState() => _UnlimitedHighCarouselState();
}

class _UnlimitedHighCarouselState extends State<UnlimitedHighCarousel> {
  num activeIndex = 0;
  PageController _controller;

  // 含有图片宽高的列表,最好是服务器返回图片的数据
  List<PictrueData> pictrueList = [
    PictrueData(
        width: 1920.0,
        height: 1152.0,
        url:
            "http://admin.soscoon.com/uploadImages/24294a8960f7cec4a5bb77276b8d1804eddc0023.jpg"),
    PictrueData(
        width: 550.0,
        height: 810.00,
        url:
            "http://admin.soscoon.com/uploadImages/72041ef01b9c8dd543511968d8659817c0086145.jpeg"),
    PictrueData(
        width: 1600.0,
        height: 900.00,
        url:
            "http://admin.soscoon.com/uploadImages/c236aa0af948e5d8812d23bd9eb1878682f247d8.jpg"),
    PictrueData(
        width: 1900.0,
        height: 1200.00,
        url:
            "http://admin.soscoon.com/uploadImages/41b2b4490204912f345b80be4fa88d7f5c9487a7.jpg"),
    PictrueData(
        width: 1920.0,
        height: 1000.00,
        url:
            "http://admin.soscoon.com/uploadImages/52a138c4dfcfbaab74daec69f128a2dd6dbf558f.jpg"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    PictrueData pictrueData = pictrueList[activeIndex];
    return Scaffold(
        body: Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: pictrueData.height * deviceWidth / pictrueData.width,
          curve: Curves.ease,
          child: Stack(
            children: <Widget>[
              NotificationListener(
                onNotification: (ScrollNotification scrollInfo) {
                  // print(scrollInfo.metrics.pixels);
                  // print(scrollInfo.metrics.viewportDimension);
                  // print(_controller.page);
                  this.setState(() {
                    this.activeIndex = _controller.page.round();
                  });
                  return true;
                },
                child: PageView(
                    controller: _controller,
                    children: pictrueList
                        .map((PictrueData data) => FadeInImage.assetNetwork(
                              placeholder: "lib/assets/loading_img.gif",
                              image: data.url,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ))
                        .toList()),
              ),
              Positioned(
                bottom: 10.0,
                right: 10.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    '${activeIndex + 1}/${pictrueList.length}',
                    style: TextStyle(
                        color: const Color(0xffffffff), fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
        ),
        Text("文本内容")
      ],
    ));
  }
}

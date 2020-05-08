import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

enum Status {
  playing,
  end,
  loading,
  pause,
}

class AudioApp extends StatefulWidget {
  const AudioApp();
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  AudioPlayer audioPlayer = AudioPlayer();
  int _current = 0;
  Status _status = Status.pause;

  final List<Map<String, String>> _audioList = [
    {'title': '父母心学', 'value': 'http://mp3.9ku.com/m4a/637791.m4a'},
    {
      'title': '郭德纲、于谦相声',
      'value': 'http://mp3.9ku.com/m4a/473290.m4a',
    },
    {
      'title': '糗事播报',
      'value': 'http://mp3.9ku.com/hot/2004/07-13/12971.mp3',
    },
  ];

  @override
  void initState() {
    super.initState();
    play();
    audioPlayer.setNotification(
        albumTitle: '《父母心学》公开课-高考的真相',
        artist: '蜜糖男孩',
        imageUrl:
            'https://qpic.y.qq.com/music_cover/X52mdv6vsP6HbocN3ajjkQIoUEP69XSwf7Faedy1QPqpnl0qmG9t1A/300?n=1',
        duration: Duration(microseconds: 5304));
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      print('Current player state: $s');
      // setState(() => playerState = s);
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  play() async {
    int result = await audioPlayer.play(
        'https://video-cdn.naoxuejia.com/2b9dc617-f9ef-47a4-978d-440af0ed8db3.audio.m3u8?pm3u8/1143200&e=1576221632&token=6HXdYoPQFVMGnhmW45qWU3OvndEZz0h5aJF_y1qy:4irLs6Y0l5C-cQ0NtG--hHz-C_8=');
    if (result == 1) {
      print('播放成功');
      setState(() {
        _status = Status.playing;
      });
      // success
    }
  }

  void _togglePlay() async {
    if (_status == Status.pause) {
      int result = await audioPlayer.resume();
      if (result == 1) {
        setState(() {
          _status = Status.playing;
        });
      }
      return;
    }
    if (_status == Status.playing) {
      int result = await audioPlayer.pause();
      if (result == 1) {
        setState(() {
          _status = Status.pause;
        });
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_audioList[_current]['title']}',
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Align(
                    child: Text(
                      '正在播放：${_audioList[_current]['title']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      color: Color(0xffededed),
                      child: FlatButton(
                        onPressed: () {
                          audioPlayer.setNotification(
                              albumTitle: 'TEST《父母心学》公开课-高考的真相',
                              artist: '蜜糖男孩',
                              imageUrl:
                                  'https://qpic.y.qq.com/music_cover/X52mdv6vsP6HbocN3ajjkQIoUEP69XSwf7Faedy1QPqpnl0qmG9t1A/300?n=1',
                              duration: Duration(microseconds: 5304));
                        },
                        child: Text('上一首'),
                      ),
                    ),
                    Container(
                      height: 40.0,
                      color: Color(0xffededed),
                      child: FlatButton(
                        onPressed: _togglePlay,
                        child: Text('${_status == Status.pause ? '播放' : '暂停'}'),
                      ),
                    ),
                    Container(
                      height: 40.0,
                      color: Color(0xffededed),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text('下一首'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    color: Color(0xffdedede),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _current = index;
                      });
                    },
                    child: SizedBox(
                      height: 60.0,
                      child: Align(
                        child: Text(
                          '${_audioList[index]['title']}',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _audioList.length,
            ),
          )
        ],
      ),
    );
  }
}

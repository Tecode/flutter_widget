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
    {
      'title': '父母心学',
      'value':
          'https://video-cdn.naoxuejia.com/351c8912-fbfb-46d9-863d-c3e40e30b283.audio.m3u8?pm3u8/1143200&e=1572086524&token=6HXdYoPQFVMGnhmW45qWU3OvndEZz0h5aJF_y1qy:X7tI3vdLZV0_3WphIDxGgr833pQ='
    },
    {
      'title': '郭德纲、于谦相声',
      'value':
          'https://audio.cos.xmcdn.com/group58/M05/07/2C/wKgLc12dkrrDYlynANlq0D3kVYM472.m4a',
    },
    {
      'title': '糗事播报',
      'value':
          'https://audio.cos.xmcdn.com/group67/M07/B5/E7/wKgMd12ytQzD1bGVAJwaOgjqlMo860.m4a',
    },
    {
      'title': '佛典小故事',
      'value':
          'http://aod.tx.xmcdn.com/group58/M01/1C/7D/wKgLgl2hmFTTva2tACzonXRJX5w933.m4a',
    },
    {
      'title': '习近平新时代中国特色社会主义思想学习纲要',
      'value':
          'http://audio.xmcdn.com/group63/M04/B0/63/wKgMaF0AjEqzchhcAHOQyw-MaWs694.m4a',
    },
    {
      'title': '小沈龙脱口秀',
      'value':
          'https://aod.tx.xmcdn.com/group67/M07/C7/82/wKgMd12z5wfw60O3AFf8jyP9Qso348.m4a',
    },
    {
      'title': '365读书|精选美文',
      'value':
          'https://aod.tx.xmcdn.com/group67/M02/A0/EB/wKgMd12xckfTAx5KAE-YPhNfLro926.m4a',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
    audioPlayer.setNotification(
      albumTitle: '《父母心学》公开课-高考的真相',
      artist: '蜜糖男孩',
      imageUrl: 'https://qpic.y.qq.com/music_cover/X52mdv6vsP6HbocN3ajjkQIoUEP69XSwf7Faedy1QPqpnl0qmG9t1A/300?n=1',
      duration: Duration(microseconds: 5304)
    );
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      print('Current player state: $s');
      // setState(() => playerState = s);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  play() async {
    int result = await audioPlayer.play(_audioList[_current]['value']);
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
                        onPressed: () {},
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

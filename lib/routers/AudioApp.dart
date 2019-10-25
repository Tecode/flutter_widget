import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

typedef void OnError(Exception exception);

const kUrl =
    "http://182.140.219.19/amobile.music.tc.qq.com/C400001txMXV1ZjiqD.m4a?guid=1174783312&vkey=20C892D89B25761D272F5084B6F9671594E6E478990A9ACDEADB7C32644D0546FA1A7AD82D756CC9660C382C4D3A1ED68C06E9F2E57E2CF9&uin=0&fromtag=66";
const kUrl2 =
    "http://182.140.219.19/amobile.music.tc.qq.com/C400003zgoRj1o8d08.m4a?guid=1174783312&vkey=B998C855202D807DBBA123FCCD149CE46A936877889D2056D31F82B612537D7960D7D353B2940D97B54F43839D90E0AE2C7BC1C41168DB38&uin=0&fromtag=66";

void main() {
  runApp(MaterialApp(home: Scaffold(body: AudioApp())));
}

enum PlayerState { stopped, playing, paused }

class AudioApp extends StatefulWidget {
  const AudioApp();
  @override
  _AudioAppState createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;

  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        setState(() => duration = audioPlayer.duration);
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  Future play(String url) async {
    await audioPlayer.play(url);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future _playLocal() async {
    await audioPlayer.play(localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    print('播放结束');
    setState(() => playerState = PlayerState.stopped);
    // 播放结束以后播放下一首
    play(kUrl2);
  }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future _loadFile() async {
    final bytes = await _loadFileBytes(kUrl,
        onError: (Exception exception) =>
            print('_loadFile => exception $exception'));

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists())
      setState(() {
        localFilePath = file.path;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            elevation: 2.0,
            color: Colors.grey[200],
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(child: _buildPlayer()),
                    localFilePath != null ? Text(localFilePath) : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              onPressed: () => _loadFile(),
                              child: Text('下载'),
                            ),
                            RaisedButton(
                              onPressed: () => _playLocal(),
                              child: Text('本地播放'),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              onPressed: () => play(kUrl),
                              child: Text('上一首'),
                            ),
                            RaisedButton(
                              onPressed: () => play(kUrl2),
                              child: Text('下一首'),
                            ),
                          ]),
                    )
                  ]),
            )));
  }

  Widget _buildPlayer() => Container(
      padding: EdgeInsets.all(16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              onPressed: isPlaying ? null : () => play(kUrl),
              iconSize: 64.0,
              icon: Icon(Icons.play_arrow),
              color: Colors.cyan),
          IconButton(
              onPressed: isPlaying ? () => pause() : null,
              iconSize: 64.0,
              icon: Icon(Icons.pause),
              color: Colors.cyan),
          IconButton(
              onPressed: isPlaying || isPaused ? () => stop() : null,
              iconSize: 64.0,
              icon: Icon(Icons.stop),
              color: Colors.cyan),
        ]),
        duration == null
            ? Container()
            : Slider(
                value: position?.inMilliseconds?.toDouble() ?? 0.0,
                onChanged: (double value) =>
                    audioPlayer.seek((value / 1000).roundToDouble()),
                min: 0.0,
                max: duration.inMilliseconds.toDouble()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                onPressed: () => mute(true),
                icon: Icon(Icons.headset_off),
                color: Colors.cyan),
            IconButton(
                onPressed: () => mute(false),
                icon: Icon(Icons.headset),
                color: Colors.cyan),
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: [
          Padding(
              padding: EdgeInsets.all(12.0),
              child: Stack(children: [
                CircularProgressIndicator(
                    value: 1.0,
                    valueColor: AlwaysStoppedAnimation(Colors.grey[300])),
                CircularProgressIndicator(
                  value: position != null && position.inMilliseconds > 0
                      ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                          (duration?.inMilliseconds?.toDouble() ?? 0.0)
                      : 0.0,
                  valueColor: AlwaysStoppedAnimation(Colors.cyan),
                  backgroundColor: Colors.yellow,
                ),
              ])),
          Text(
              position != null
                  ? "${positionText ?? ''} / ${durationText ?? ''}"
                  : duration != null ? durationText : '',
              style: TextStyle(fontSize: 24.0))
        ])
      ]));
}

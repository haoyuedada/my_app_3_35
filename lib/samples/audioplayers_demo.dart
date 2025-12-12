import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioplayersDemo extends StatefulWidget {
  @override
  _AudioplayersDemoState createState() => _AudioplayersDemoState();
}

class _AudioplayersDemoState extends State<AudioplayersDemo> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentPosition = "00:00";
  String _totalDuration = "00:00";

  @override
  void initState() {
    super.initState();
    // 监听音频播放状态
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    // 监听音频时长
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _totalDuration = _formatDuration(duration);
      });
    });

    // 监听音频播放位置
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPosition = _formatDuration(position);
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // 播放网络音频
  Future<void> _playAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      // 播放示例音频
      await _audioPlayer.play(UrlSource('https://cdn.ear0.com/upload/file/20251207/1733510401723643.mp3'));
    }
  }

  // 暂停音频
  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  // 停止音频
  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  // 格式化时长为mm:ss格式
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('audioplayers Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '音频播放测试',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Text(
              '$_currentPosition / $_totalDuration',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 48,
                    color: Colors.blue,
                  ),
                  onPressed: _playAudio,
                ),
                IconButton(
                  icon: Icon(
                    Icons.stop,
                    size: 48,
                    color: Colors.blue,
                  ),
                  onPressed: _stopAudio,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '提示：点击播放按钮开始播放网络音频',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
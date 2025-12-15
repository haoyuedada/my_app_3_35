import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class WakelockDemo extends StatefulWidget {
  @override
  _WakelockDemoState createState() => _WakelockDemoState();
}

class _WakelockDemoState extends State<WakelockDemo> {
  // 保持屏幕常亮状态
  bool _isWakelockEnabled = false;

  // 切换屏幕常亮状态
  Future<void> _toggleWakelock() async {
    setState(() {
      _isWakelockEnabled = !_isWakelockEnabled;
    });
    
    try {
      if (_isWakelockEnabled) {
        print("开启屏幕常亮");
        await Wakelock.enable();
      } else {
        print("关闭屏幕常亮");
        await Wakelock.disable();
      }
    } catch (e) {
      print('切换屏幕常亮失败: $e');
      setState(() {
        _isWakelockEnabled = !_isWakelockEnabled; // 切换失败恢复原来状态
      });
    }
  }

  // 检查当前屏幕常亮状态
  Future<void> _checkWakelockStatus() async {
    bool isEnabled = await Wakelock.enabled;
    setState(() {
      _isWakelockEnabled = isEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkWakelockStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wakelock Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 屏幕常亮状态指示器
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isWakelockEnabled ? Colors.green : Colors.red,
              ),
              child: Center(
                child: Icon(
                  _isWakelockEnabled ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            
            SizedBox(height: 32.0),
            
            // 状态文字
            Text(
              _isWakelockEnabled ? '屏幕常亮已开启' : '屏幕常亮已关闭',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: 48.0),
            
            // 切换按钮
            SizedBox(
              width: 250,
              height: 48,
              child: ElevatedButton(
                onPressed: _toggleWakelock,
                child: Text(
                  _isWakelockEnabled ? '关闭屏幕常亮' : '开启屏幕常亮',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // 刷新状态按钮
            TextButton(
              onPressed: _checkWakelockStatus,
              child: Text('刷新状态'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotificationsDemo extends StatefulWidget {
  @override
  _FlutterLocalNotificationsDemoState createState() =>
      _FlutterLocalNotificationsDemoState();
}

class _FlutterLocalNotificationsDemoState
    extends State<FlutterLocalNotificationsDemo> {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    // 初始化配置
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    
    // 初始化插件
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 显示通知
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // 频道ID
      'your_channel_name', // 频道名称
      channelDescription: 'your_channel_description', // 频道描述
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    await _flutterLocalNotificationsPlugin.show(
      0, // 通知ID
      '测试通知标题', // 通知标题
      '这是一个flutter_local_notifications的测试通知', // 通知内容
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_local_notifications Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'flutter_local_notifications 演示',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showNotification,
              child: Text('显示通知'),
            ),
          ],
        ),
      ),
    );
  }
}
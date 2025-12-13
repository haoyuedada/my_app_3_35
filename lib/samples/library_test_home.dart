import 'package:flutter/material.dart';
import 'audioplayers_demo.dart';
import 'connectivity_plus_demo.dart';
import 'device_info_plus_demo.dart';
import 'package_info_plus_demo.dart';
import 'flutter_local_notifications_demo.dart';
import 'flutter_widget_from_html_core_demo.dart';

class LibraryTestHome extends StatefulWidget {
  @override
  _LibraryTestHomeState createState() => _LibraryTestHomeState();
}

class _LibraryTestHomeState extends State<LibraryTestHome> {
  // 所有测试功能入口的数据
  final List<FunctionItem> _allFunctionItems = [
    FunctionItem(
      title: 'audioplayers Demo',
      description: '音频播放功能演示',
      keyword: 'audio audioplayers 音频 播放',
      builder: (context) => AudioplayersDemo(),
    ),
    FunctionItem(
      title: 'connectivity_plus Demo',
      description: '网络连接状态检测功能演示',
      keyword: 'connectivity network 网络 连接 检测',
      builder: (context) => ConnectivityPlusDemo(),
    ),
    FunctionItem(
      title: 'device_info_plus Demo',
      description: '设备信息获取功能演示',
      keyword: 'device info device_info_plus 设备 信息',
      builder: (context) => DeviceInfoPlusDemo(),
    ),
    FunctionItem(
      title: 'package_info_plus Demo',
      description: '应用信息获取功能演示',
      keyword: 'package info package_info_plus 应用 信息',
      builder: (context) => PackageInfoPlusDemo(),
    ),
    FunctionItem(
      title: 'flutter_local_notifications Demo',
      description: '本地通知功能演示',
      keyword: 'notification local_notifications 通知 本地通知',
      builder: (context) => FlutterLocalNotificationsDemo(),
    ),
    FunctionItem(
      title: 'flutter_widget_from_html_core Demo',
      description: 'HTML内容渲染功能演示',
      keyword: 'html widget render html渲染 widget',
      builder: (context) => FlutterWidgetFromHtmlCoreDemo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter三方库测试'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _allFunctionItems.length,
        itemBuilder: (context, index) {
          final item = _allFunctionItems[index];
          return _buildFunctionCard(item, context);
        },
      ),
    );
  }

  // 构建功能卡片
  Widget _buildFunctionCard(FunctionItem item, BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(
            _getIconForFunction(item.title),
            color: Colors.blue,
          ),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Text(item.description),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: item.builder),
          );
        },
      ),
    );
  }

  // 根据功能标题获取对应图标
  IconData _getIconForFunction(String title) {
    if (title.contains('audioplayers') || title.contains('音频')) {
      return Icons.music_note;
    } else if (title.contains('connectivity') || title.contains('网络') || title.contains('连接')) {
      return Icons.network_check;
    } else if (title.contains('device_info_plus') || title.contains('设备') || title.contains('信息')) {
      return Icons.devices;
    } else if (title.contains('package_info_plus') || title.contains('应用') || title.contains('版本')) {
      return Icons.info;
    } else if (title.contains('flutter_local_notifications') || title.contains('通知')) {
      return Icons.notifications;
    } else if (title.contains('flutter_widget_from_html_core') || title.contains('html')) {
      return Icons.description;
    }
    return Icons.apps;
  }
}

// 功能项数据模型（和main.dart中的一致）
class FunctionItem {
  final String title;
  final String description;
  final String keyword;
  final WidgetBuilder builder;

  FunctionItem({
    required this.title,
    required this.description,
    required this.keyword,
    required this.builder,
  });
}
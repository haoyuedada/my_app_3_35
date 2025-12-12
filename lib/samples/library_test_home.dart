import 'package:flutter/material.dart';
import 'audioplayers_demo.dart';

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
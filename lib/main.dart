import 'package:flutter/material.dart';
import 'samples/webview_page.dart';
import 'samples/flutter_inappwebview.dart';
import 'samples/my_count.dart';
import 'samples/StatelessWidget_demo.dart';
import 'samples/life_cycle.dart';
import 'samples/onWillPopDemo.dart';
import 'samples/fluttertoast_demo.dart';
import 'samples/library_test_home.dart';

// 获取Flutter版本信息
String getFlutterVersion() {
  // 直接返回Flutter版本信息
  return '3.9.2'; // 这是Flutter SDK的版本号，不是Dart SDK的版本号
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 搜索关键词
  String _searchText = '';
  
  // Flutter版本信息
  String _flutterVersion = getFlutterVersion();
  
  // 所有功能入口的数据
  final List<FunctionItem> _allFunctionItems = [
    FunctionItem(
      title: '打开 WebView - local',
      description: '使用本地WebView打开必应搜索',
      keyword: 'webview local 本地 浏览器',
      builder: (context) => WebViewPage(initialUrl: 'https://cn.bing.com/'),
    ),
    FunctionItem(
      title: '打开 flutter_inappwebview - online',
      description: '使用在线WebView组件',
      keyword: 'webview online 在线 浏览器 inapp',
      builder: (context) => FlutterInappwebview(),
    ),
    FunctionItem(
      title: '打开 计数器',
      description: '计数器功能演示',
      keyword: '计数器 count 数字 计算',
      builder: (context) => MyCountPage(title: 'Count Demo'),
    ),
    FunctionItem(
      title: 'StatelessWidget Demo',
      description: '无状态组件演示',
      keyword: 'stateless 无状态 组件 widget',
      builder: (context) => StatelessWidgetDemo(text: "This is StatelessWidgetDemo"),
    ),
    FunctionItem(
      title: 'lifeCycle Demo',
      description: '生命周期演示',
      keyword: 'lifecycle 生命周期 状态',
      builder: (context) => CounterWidget(),
    ),
    FunctionItem(
      title: 'onWillPop Demo',
      description: '拦截返回键演示',
      keyword: 'onWillPop 拦截返回',
      builder: (context) => OnWillPopDemo(),
    ),
    FunctionItem(
      title: 'Fluttertoast Demo',
      description: 'toast提示功能演示',
      keyword: 'toast fluttertoast 提示',
      builder: (context) => FluttertoastDemo(),
    ),
    FunctionItem(
      title: 'Flutter三方库测试',
      description: '各种Flutter三方库的测试demo入口',
      keyword: 'library 三方库 测试 demo',
      builder: (context) => LibraryTestHome(),
    ),
  ];
  
  // 获取过滤后的功能列表
  List<FunctionItem> get _filteredItems {
    if (_searchText.isEmpty) {
      return _allFunctionItems;
    }
    
    final keyword = _searchText.toLowerCase();
    return _allFunctionItems.where((item) {
      return item.title.toLowerCase().contains(keyword) ||
             item.description.toLowerCase().contains(keyword) ||
             item.keyword.toLowerCase().contains(keyword);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        actions: [
          // 清空搜索按钮
          if (_searchText.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchText = '';
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // 展示 Flutter 版本
          Container(
            color: Colors.blue[50],
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            child: Text(
              'Dart Version: $_flutterVersion',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // 原有内容
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }
  
  // 构建搜索输入框
  Widget _buildSearchField() {
    return TextField(
      controller: TextEditingController(text: _searchText),
      decoration: InputDecoration(
        hintText: '搜索功能入口...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
    );
  }
  
  // 构建主体内容
  Widget _buildBody() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              '未找到匹配的功能',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '请尝试其他搜索关键词',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return _buildFunctionCard(item, context);
      },
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
    if (title.contains('WebView') || title.contains('浏览器')) {
      return Icons.public;
    } else if (title.contains('计数器') || title.contains('Count')) {
      return Icons.add_circle_outline;
    } else if (title.contains('Stateless') || title.contains('无状态')) {
      return Icons.widgets;
    } else if (title.contains('lifeCycle') || title.contains('生命周期')) {
      return Icons.motorcycle;
    } else if (title.contains('Fluttertoast') || title.contains('toast')) {
      return Icons.message;
    } else if (title.contains('三方库') || title.contains('library')) {
      return Icons.library_books;
    }
    return Icons.apps;
  }
}

// 功能项数据模型
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
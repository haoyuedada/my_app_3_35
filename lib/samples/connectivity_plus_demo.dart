import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityPlusDemo extends StatefulWidget {
  @override
  _ConnectivityPlusDemoState createState() => _ConnectivityPlusDemoState();
}

class _ConnectivityPlusDemoState extends State<ConnectivityPlusDemo> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    // 初始化网络连接状态
    _initializeConnectivity();
    // 监听网络连接状态变化
    _connectivityStream = Connectivity().onConnectivityChanged;
    // 监听网络连接状态变化
    _connectivityStream.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  // 初始化网络连接状态
  Future<void> _initializeConnectivity() async {
    try {
      final result = await Connectivity().checkConnectivity();
      setState(() {
        _connectivityResult = result;
      });
    } catch (e) {
      print('获取网络连接状态失败: $e');
    }
  }

  // 获取网络连接状态的描述
  String _getConnectivityDescription(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return '移动网络';
      case ConnectivityResult.ethernet:
        return '以太网';
      case ConnectivityResult.none:
        return '无网络';
      default:
        return '未知';
    }
  }

  // 获取网络连接状态的颜色
  Color _getConnectivityColor(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
        return Colors.green;
      case ConnectivityResult.none:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('connectivity_plus Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '网络连接状态',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            // 显示当前网络连接状态
            Icon(
              Icons.network_check,
              size: 64,
              color: _getConnectivityColor(_connectivityResult),
            ),
            SizedBox(height: 20),
            Text(
              '当前网络: ${_getConnectivityDescription(_connectivityResult)}',
              style: TextStyle(
                fontSize: 20,
                color: _getConnectivityColor(_connectivityResult),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            // 手动检查网络连接状态
            ElevatedButton(
              onPressed: _initializeConnectivity,
              child: Text('手动检查网络状态'),
            ),
          ],
        ),
      ),
    );
  }
}
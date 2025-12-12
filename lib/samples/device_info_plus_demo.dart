import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoPlusDemo extends StatefulWidget {
  @override
  _DeviceInfoPlusDemoState createState() => _DeviceInfoPlusDemoState();
}

class _DeviceInfoPlusDemoState extends State<DeviceInfoPlusDemo> {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceInfo = {};

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    try {
      final info = await _deviceInfoPlugin.deviceInfo;
      setState(() {
        _deviceInfo = info.data;
      });
    } catch (e) {
      setState(() {
        _deviceInfo = {'error': '获取设备信息失败: $e'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('device_info_plus Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '设备信息',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                // 移除了无效的margin属性，因为TextStyle没有margin属性
              ),
              SizedBox(height: 20.0), // 使用SizedBox来创建间距
              _deviceInfo.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : _deviceInfo.containsKey('error')
                      ? Center(child: Text(_deviceInfo['error']))
                      : _buildDeviceInfoList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceInfoList() {
    return Column(
      children: _deviceInfo.entries
          .map((entry) => Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        entry.value.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
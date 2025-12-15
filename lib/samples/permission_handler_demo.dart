import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerDemo extends StatefulWidget {
  @override
  _PermissionHandlerDemoState createState() => _PermissionHandlerDemoState();
}

class _PermissionHandlerDemoState extends State<PermissionHandlerDemo> {
  // 权限状态
  Map<Permission, PermissionStatus> _permissionStatus = {};

  // 需要测试的权限列表
  final List<Permission> _permissions = [
    Permission.camera,
    Permission.photos,
    Permission.locationWhenInUse,
    Permission.microphone,
    Permission.phone,
  ];

  @override
  void initState() {
    super.initState();
    _checkPermissionsStatus();
  }

  // 检查所有权限状态
  Future<void> _checkPermissionsStatus() async {
    Map<Permission, PermissionStatus> statuses =
        await _permissions.request();
    
    setState(() {
      print("chy , ${statuses}");
      _permissionStatus = statuses;
    });
  }

  // 打开应用设置
  Future<void> _openAppSettings() async {
    await openAppSettings();
  }

  // 权限状态显示文本
  String _getStatusText(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return '已授权';
      case PermissionStatus.denied:
        return '已拒绝';
      case PermissionStatus.permanentlyDenied:
        return '永久拒绝';
      case PermissionStatus.restricted:
        return '受限制';
      case PermissionStatus.limited:
        return '有限授权';
      default:
        return '未知';
    }
  }

  // 权限状态显示颜色
  Color _getStatusColor(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
        return Colors.orange;
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.restricted:
        return Colors.red;
      case PermissionStatus.limited:
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  // 权限名称
  String _getPermissionName(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return '相机权限';
      case Permission.photos:
        return '相册权限';
      case Permission.locationWhenInUse:
        return '位置权限';
      case Permission.microphone:
        return '麦克风权限';
      case Permission.phone:
        return '电话权限';
      default:
        return '未知权限';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Handler Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '权限状态',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.0),
            
            // 权限状态列表
            Expanded(
              child: ListView.builder(
                itemCount: _permissions.length,
                itemBuilder: (context, index) {
                  final permission = _permissions[index];
                  final status = _permissionStatus[permission];
                  
                  return Card(
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: ListTile(
                      title: Text(_getPermissionName(permission)),
                      trailing: status != null
                          ? Text(
                              _getStatusText(status),
                              style: TextStyle(
                                color: _getStatusColor(status),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // 刷新按钮
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _checkPermissionsStatus,
                child: Text('请求权限'),
              ),
            ),
            
            SizedBox(height: 12.0),
            
            // 打开设置按钮
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: _openAppSettings,
                child: Text('打开应用设置'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
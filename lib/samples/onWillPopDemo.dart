import 'package:flutter/material.dart';

class OnWillPopDemo extends StatelessWidget {
  const OnWillPopDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 WillPopScope 包裹页面内容
    return WillPopScope(
      onWillPop: () async {
        // 在这里写入你的拦截逻辑
        bool shouldPop = await _showExitConfirmationDialog(context);
        // 返回 true 允许返回，返回 false 阻止返回
        return shouldPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('拦截返回示例'),
        ),
        body: const Center(
          child: Text('尝试按下返回键或使用手势返回。'),
        ),
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('确定要离开吗？'),
            content: const Text('当前可能有未保存的更改。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // 取消，不离开
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // 确认离开
                child: const Text('确定'),
              ),
            ],
          ),
        )) ??
        false; // 如果对话框意外关闭，默认为false（阻止返回）
  }
}
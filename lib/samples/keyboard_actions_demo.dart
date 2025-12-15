import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardActionsExample extends StatefulWidget {
  const KeyboardActionsExample({super.key});

  @override
  _KeyboardActionsExampleState createState() => _KeyboardActionsExampleState();
}

class _KeyboardActionsExampleState extends State<KeyboardActionsExample> {
  // 1. 创建焦点节点（FocusNode）
  final FocusNode _focusNode1 = FocusNode(); // 用于第一个输入框
  final FocusNode _focusNode2 = FocusNode(); // 用于第二个输入框
  final FocusNode _focusNode3 = FocusNode(); // 用于第三个“选择器”

  // 用于表单控制和取值
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _selectedOption = '选项 A'; // 模拟选择器的值

  @override
  void dispose() {
    // 释放资源
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  // 2. 配置 KeyboardActions（核心部分）
  KeyboardActionsConfig _buildKeyboardConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL, // 适用于所有平台
      keyboardBarColor: Colors.grey[100], // 工具栏颜色
      nextFocus: true, // 启用“下一项”功能
      actions: [
        // 为第一个输入框配置动作
        KeyboardActionsItem(
          focusNode: _focusNode1,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(), // 点击按钮收起键盘
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('收起',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              );
            },
          ],
        ),
        // 为第二个输入框配置动作
        KeyboardActionsItem(
          focusNode: _focusNode2,
          displayDoneButton: false, // 不显示默认的“完成”按钮
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  // 自定义动作：清空输入框
                  _controller2.clear();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.clear, color: Colors.grey),
                ),
              );
            },
          ],
        ),
        // 为第三个“选择器”配置动作
        KeyboardActionsItem(
          focusNode: _focusNode3,
          // 当此项目获得焦点时，显示一个“选择”按钮
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => _showSelectionDialog(context),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('选择',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  // 模拟一个选择对话框
  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('请选择一个选项'),
        children: ['选项 A', '选项 B', '选项 C']
            .map((option) => SimpleDialogOption(
                  onPressed: () {
                    setState(() {
                      _selectedOption = option;
                    });
                    Navigator.pop(ctx);
                    _focusNode3.unfocus(); // 选择后收起键盘
                  },
                  child: Text(option),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KeyboardActions 示例')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        // 3. 用 KeyboardActions 包裹表单区域
        child: KeyboardActions(
          config: _buildKeyboardConfig(context),
          autoScroll: true, // 自动滚动以确保输入框可见
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text('请填写以下信息：', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 30),
                // 输入框 1：普通文本
                TextFormField(
                  focusNode: _focusNode1,
                  controller: _controller1,
                  decoration: const InputDecoration(
                    labelText: '用户名',
                    border: OutlineInputBorder(),
                    hintText: '请输入用户名',
                  ),
                  textInputAction: TextInputAction.next, // 键盘上的“下一项”
                ),
                const SizedBox(height: 20),
                // 输入框 2：数字输入
                TextFormField(
                  focusNode: _focusNode2,
                  controller: _controller2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '年龄',
                    border: OutlineInputBorder(),
                    hintText: '请输入年龄',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                // 输入框 3：模拟的下拉选择器（实际是一个可获得焦点的文本框）
                GestureDetector(
                  onTap: () {
                    // 点击时获取焦点，会触发键盘工具栏显示
                    FocusScope.of(context).requestFocus(_focusNode3);
                    // 同时弹出选择对话框
                    _showSelectionDialog(context);
                  },
                  child: AbsorbPointer(
                    // 吸收指针事件，让 GestureDetector 生效
                    child: TextFormField(
                      focusNode: _focusNode3,
                      enabled: true,
                      controller: TextEditingController(text: _selectedOption),
                      decoration: const InputDecoration(
                        labelText: '选择项',
                        border: OutlineInputBorder(),
                        hintText: '请点击选择',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // 提交表单时，收起所有键盘
                    FocusScope.of(context).unfocus();
                    _showSubmittedDialog(context);
                  },
                  child: const Text('提交信息'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('提交的信息'),
        content: Text('用户名: ${_controller1.text}\n'
                     '年龄: ${_controller2.text}\n'
                     '选择项: $_selectedOption'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
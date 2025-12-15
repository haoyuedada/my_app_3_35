import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';

class ImageGallerySaverDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image_gallery_saver Demo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  // 从网络下载图片并保存到相册
                  const url = 'https://picsum.photos/200';
                  // 先下载图片为Uint8List
                  final http.Response response = await http.get(Uri.parse(url));
                  final result = await ImageGallerySaver.saveImage(response.bodyBytes);
                  _showResult(context, result);
                } catch (e) {
                  _showError(context, e.toString());
                }
              },
              child: Text('保存网络图片到相册'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // 从assets加载图片并保存到相册
                  final ByteData data = await rootBundle.load('assets/fig-without-poppy.jpeg');
                  final Uint8List bytes = data.buffer.asUint8List();
                  final result = await ImageGallerySaver.saveImage(bytes);
                  _showResult(context, result);
                } catch (e) {
                  _showError(context, e.toString());
                }
              },
              child: Text('保存本地Assets图片到相册'),
            ),
          ],
        ),
      ),
    );
  }

  void _showResult(BuildContext context, dynamic result) {
    if (result != null && result['isSuccess'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('图片保存成功')),
      );
    } else {
      _showError(context, '图片保存失败: ${result?.toString() ?? '未知错误'}');
    }
  }

  void _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('错误: $error')),
    );
  }
}
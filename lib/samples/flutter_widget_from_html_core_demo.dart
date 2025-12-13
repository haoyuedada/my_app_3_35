import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class FlutterWidgetFromHtmlCoreDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter_widget_from_html_core Demo'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: HtmlWidget(
          '''
            <h1>HTML内容渲染演示</h1>
            <p>这是一个使用 <strong>flutter_widget_from_html_core</strong> 渲染的HTML示例。</p>
            
            <h2>标题2</h2>
            <p>支持的标签:</p>
            <ul>
              <li>段落 <p></li>
              <li>标题 <h1>-<h6></li>
              <li>列表 <ul>/<ol>/<li></li>
              <li>强调 <strong>/<em></li>
            </ul>
            
            <h3>链接示例</h3>
            <p>访问 <a href="https://flutter.dev">Flutter官方网站</a> 了解更多信息。</p>
            
            <h3>样式示例</h3>
            <p style="color: blue;">蓝色文本</p>
            <p style="font-size: 20px;">大号文本</p>
            <p style="text-align: center;">居中对齐</p>
          ''',
        ),
      ),
    );
  }
}
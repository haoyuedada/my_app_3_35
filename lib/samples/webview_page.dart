import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final String initialUrl; // 初始加载的网址

  const WebViewPage({Key? key, required this.initialUrl}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController _webViewController; // WebView控制器[citation:5]
  double _progress = 0; // 加载进度
  String _pageTitle = ''; // 页面标题
  bool _isSecure = false; // 是否为安全连接（HTTPS）
  PullToRefreshController? _pullToRefreshController; // 下拉刷新控制器

  @override
  void initState() {
    super.initState();
    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        // 下拉刷新时重新加载网页
        await _webViewController.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // 安全状态图标
            Icon(
              _isSecure ? Icons.lock_outline : Icons.lock_open_outlined,
              size: 18,
            ),
            SizedBox(width: 8),
            // 动态显示网页标题或URL
            Expanded(
              child: Text(
                _pageTitle.isNotEmpty ? _pageTitle : widget.initialUrl,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          // 刷新按钮
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _webViewController.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 主体：InAppWebView 组件
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.initialUrl)),
            // 获取控制器，用于后续操作[citation:5]
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            // 监听加载进度[citation:10]
            onProgressChanged: (controller, progress) {
              setState(() {
                _progress = progress / 100;
              });
              // 下拉刷新完成
              if (progress == 100) {
                _pullToRefreshController?.endRefreshing();
              }
            },
            // 开始加载[citation:5]
            onLoadStart: (controller, url) async {
              setState(() {
                _pageTitle = '加载中...';
              });
              print('开始加载: $url');
            },
            // 完成加载[citation:5]
            onLoadStop: (controller, url) async {
              // 获取页面标题[citation:10]
              String? title = await controller.getTitle();
              setState(() {
                _pageTitle = title ?? url?.toString() ?? '';
              });
              // 检查是否为安全连接
              final sslCertificate = await controller.getCertificate();
              setState(() {
                _isSecure = sslCertificate != null;
              });
              print('加载完成: $url');
            },
            // 加载出错[citation:5][citation:10]
            onReceivedError: (controller, request, error) async {
              print('加载错误: ${error.description}');
              // 加载自定义错误页面（含霸王龙游戏）[citation:10]
              if (request.url != null) {
                controller.loadData(
                  data: """
                  <!DOCTYPE html>
                  <html>
                  <head>
                    <style>
                      ${await controller.getTRexRunnerCss()}
                    </style>
                  </head>
                  <body>
                    ${await controller.getTRexRunnerHtml()}
                    <div style="text-align:center; padding:20px;">
                      <h3>无法加载页面</h3>
                      <p>${error.description}</p>
                    </div>
                  </body>
                  </html>
                  """,
                );
              }
            },
            // 下拉刷新控制
            pullToRefreshController: _pullToRefreshController,
            // 允许执行JavaScript（必须开启，很多交互功能需要）[citation:1]
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true, // 启用JavaScript[citation:1]
                useShouldOverrideUrlLoading: true,
              ),
            ),
          ),
          // 顶部进度条
          if (_progress < 1.0)
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.transparent,
              minHeight: 2,
            ),
        ],
      ),
      // 底部导航栏，包含常用控制按钮
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 后退
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                if (await _webViewController.canGoBack()) {
                  await _webViewController.goBack();
                }
              },
            ),
            // 前进
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () async {
                if (await _webViewController.canGoBack()) {
                  await _webViewController.goForward();
                }
              },
            ),
            // 首页
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _webViewController.loadUrl(
                  urlRequest: URLRequest(url: WebUri(widget.initialUrl)),
                );
              },
            ),
            // 调用JavaScript示例[citation:7]
            IconButton(
              icon: Icon(Icons.code),
              onPressed: () async {
                // 调用网页中的JavaScript函数并获取返回值[citation:7]
                var result = await _webViewController.evaluateJavascript(
                  source: "window.alert('Hello from Flutter!'); return '执行成功';",
                );
                print('JavaScript执行结果: $result');
              },
            ),
          ],
        ),
      ),
    );
  }
}
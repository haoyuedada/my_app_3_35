import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MobileScannerDemo extends StatefulWidget {
  @override
  _MobileScannerDemoState createState() => _MobileScannerDemoState();
}

class _MobileScannerDemoState extends State<MobileScannerDemo> {
  MobileScannerController _controller = MobileScannerController();
  bool _torchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Scanner Demo'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                _torchOn = !_torchOn;
                _controller.toggleTorch();
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                _showBarcodeResult(context, barcode);
              }
            },
          ),
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '请将二维码/条形码置于扫描框内',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBarcodeResult(BuildContext context, Barcode barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('扫描结果'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('类型: ${barcode.type.name}'),
            SizedBox(height: 8),
            Text('内容: ${barcode.rawValue}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('确定'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FluttertoastDemo extends StatelessWidget {
  const FluttertoastDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluttertoast Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "This is a default toast",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
                );
              },
              child: Text('Show Default Toast'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Long toast message with custom styling",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 18.0
                );
              },
              child: Text('Show Long Toast'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Toast at the top",
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              },
              child: Text('Show Toast at Top'),
            ),
          ],
        ),
      ),
    );
  }
}
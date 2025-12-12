import 'package:flutter/material.dart';

class StatelessWidgetDemo extends StatelessWidget  {
  const StatelessWidgetDemo({
    Key? key,  
    required this.text,
    this.backgroundColor = Colors.grey, //默认为灰色
  }):super(key:key);
    
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}
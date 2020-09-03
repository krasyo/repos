import 'package:flutter/material.dart';

class CustomAppbar extends AppBar {
  final String titleString;

  CustomAppbar({ this.titleString = '' });

  @override
  Widget get title => Text(titleString, style: TextStyle(color: Colors.black));

  @override
  IconThemeData get iconTheme => IconThemeData(
      color: Colors.black
  );

  @override
  Color get backgroundColor => Colors.transparent;

  @override
  bool get centerTitle => true;

  @override
  double get elevation => 0.0;
}
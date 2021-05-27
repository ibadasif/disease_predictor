import 'package:disease/image_picker.dart';
import 'package:disease/login.dart';
import 'package:disease/screens/authenticate/login_2.dart';
import 'package:disease/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}

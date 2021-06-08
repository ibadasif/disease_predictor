import 'package:disease/screens/image_picker.dart';
import 'package:disease/models/user.dart';
import 'package:disease/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return SaveImageDemo();
    }
  }
}

import 'package:disease/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'Utility.dart';

class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Select Image ";

  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {
  Future<File> imageFile;
  Image imageFromPreferences;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          Utility.saveImageToPreferences(
              Utility.base64String(snapshot.data.readAsBytesSync()));
          print(Image.file(
            snapshot.data,
          ));
          return Image.file(
            snapshot.data,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.white
          )
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center
        ,
        style: TextStyle(
        color: Colors.white
        )
          );
        }
      },
    );
  }

  final AuthService _auth = AuthService();
  @override

  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xff18203d);
    final Color secondaryColor = Color(0xff232c51);
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery(ImageSource.gallery);
              setState(() {
                imageFromPreferences = null;
              });
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.person,color: Colors.white,),
              label: Text('Logout',style: TextStyle(color: Colors.white),),
              onPressed:() async {
              await _auth.signOut();
              }
              )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            imageFromGallery(),
            SizedBox(
              height: 20.0,
            ),
            null == imageFromPreferences ? Container() : imageFromPreferences,
          FlatButton(onPressed: ()async{
            print(await Utility.getImageFromPreferences());
          }, child: Text('Print Console',
          style: TextStyle(
            color: Colors.white
          ),))
        ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:disease/models/api_model.dart';
import 'package:disease/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Utility.dart';
import '../models/disease.dart';

class SaveImageDemo extends StatefulWidget {
  SaveImageDemo() : super();

  final String title = "Select Image ";

  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {
  Future<File> imageFile;
  Image imageFromPreferences;

  final Color logoGreen = Color(0xff25bcbb);

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
          return const Text('Error Picking Image',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white));
        } else {
          return const Text('No Image Selected',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white));
        }
      },
    );
  }

  final AuthService _auth = AuthService();
  String comingResponse;

  Future<String> get_response(String modelJson) async {
    final Response response = await post(
        'http://project3214.pythonanywhere.com/upload/',
        body: modelJson);
    print('ImageResponseStatusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      final dynamic responseBody = jsonDecode(response.body);
      print(response.body);
      print(responseBody);
      Disease disease = Disease.fromJson(responseBody);
      return disease.label;
    }
  }

  final String acne =
      "Medications:\n\n1- Isotretion Cream.\n2- Clindamycin Plus Tetrinoin.\n\nApply to affected areas once or twice daily or as directed by a dermatologist.";
  final String psoriasis =
      "Medications:\n\n1-Topical Steroids Cream.\n2- Hydrocortisone.\n\nApply to affected areas once or twice daily or as directed by a dermatologist";
  final String eczema =
      "Medications:\n\n1- Hydrophil Lotion.\n2- Hydrocortisone Cream.\n\nApply to affected areas once or twice daily or as directed by a dermatologist";

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
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              })
        ],
      ),
      body: SingleChildScrollView(
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
            FlatButton(
              onPressed: () async {
                String _image = await Utility.getImageFromPreferences();
                Model model = Model(img: _image);
                final String modelJson = json.encode(model);
                print(modelJson);
                String label = await get_response(modelJson);
                setState(() {
                  comingResponse = label;
                });
                print(comingResponse);
              },
              color: logoGreen,
              child: Text('Predict Disease',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            comingResponse == null
                ? Text('')
                : Text(
                    comingResponse,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
            SizedBox(
              height: 20.0,
            ),
            if (comingResponse == "Acne")
              Text(
                acne,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            else if (comingResponse == "Psoriasis")
              Text(
                psoriasis,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            else if (comingResponse == "Eczema")
              Text(
                eczema,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
          ],
        ),
      ),
    );
  }
}

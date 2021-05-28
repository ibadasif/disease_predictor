import 'package:disease/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in to continue',
                    textAlign: TextAlign.center,
                    style:
                    GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Enter your email and password below to continue to the Disease Prediction Page and let the learning begin!',
                    textAlign: TextAlign.center,
                    style:
                    GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    validator:  (val) => val.isEmpty? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() =>  email = val);

                      }
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                      validator:  (val) => val.length < 6 ? 'Enter a password of atleast 6 Chars' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() =>  password = val);

                      }
                  ),
                  SizedBox(height: 40),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() => error = 'Incorrect Credentials' );
                        }

                      }

                    },
                    color: logoGreen,
                    child: Text('Login',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _buildTextField(TextEditingController controller, IconData icon,
      String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}
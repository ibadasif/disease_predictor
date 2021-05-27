import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

   final FirebaseAuth _auth = FirebaseAuth.instance;

   // sign in anon
   Future signInAnon() async {

     try{
       AuthResult result = await _auth.signInAnonymously();
       FirebaseUser user = result.user;
       return user;

     }catch(e){
       print(e.toString());
       return null;
     }
   }

   Future signInWithEmailAndPassword(String email, String password) async {
     try {
       AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       FirebaseUser user = result.user;
       return user;
     } catch (error) {
       print(error.toString());
       return null;
     }
   }

  // register with emial & password

  // sign out

}


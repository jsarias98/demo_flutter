import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class firebaseState extends StatefulWidget{
  @override
  firebaseStateView createState() => firebaseStateView();

}
class firebaseStateView extends State<firebaseState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return user;
    } catch (error) {
      print(error);
    }
  }
  Future<FirebaseUser> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      AlertDialog(
          title: new Text('sesion cerrada'));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("signIn"),
              onPressed: _handleSignIn,
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.lightGreen,
            ),
            RaisedButton(
              child: Text("signOut"),
              onPressed: _handleSignOut,
              color: Colors.redAccent,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.red,
            )
          ],
        ),
      );
  }
}
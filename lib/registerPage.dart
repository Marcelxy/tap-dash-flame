import 'mainPage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap Dash',
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap Dash'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: FlutterLogo(size: 150),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: GoogleSignInButton(
                  onPressed: () {
                    _signInWithGoogle().catchError((e) => print(e));
                  },
                  darkMode: true,
                  borderRadius: 10,
                  text: 'Anmelden mit Google',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: FacebookSignInButton(
                  onPressed: () {},
                  borderRadius: 10,
                  text: 'Anmelden mit Facebook',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    if (user != null) {
      _createPlayerInDatabase(user);
      print("Angemeldet über Google mit " + user.displayName);
      print(user);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
      return user;
    }
    return null;
  }

  void _createPlayerInDatabase(FirebaseUser user) {
    Firestore.instance.collection('player').document().setData({ 'userName' : user.displayName});
  }
}

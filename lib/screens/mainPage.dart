import 'package:tap_dash_flame/screens/registerPage.dart';
import 'package:tap_dash_flame/screens/highscorePage.dart';
import 'package:tap_dash_flame/datastructures/player.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap Dash',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tap Dash'),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Hallo ' + getCurrentUser().toString()),
                RaisedButton(
                  child: Text('Rangliste'),
                  onPressed: () => _showHighscore(),
                ),
                RaisedButton(
                  child: Text('Ausloggen'),
                  onPressed: () => _signOutGoogle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showHighscore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HighscorePage()),
    );
    print("Spieler wechselt zur Ranglistenansicht.");
  }

  void _signOutGoogle() async {
    await _googleSignIn.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
    print("Spieler hat sich ausgeloggt.");
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.displayName);
    return user.displayName;
  }
}

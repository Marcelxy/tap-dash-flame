import 'registerPage.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                Text('Hallo '),
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

  void _signOutGoogle() async {
    await _googleSignIn.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
    print("Spieler hat sich ausgeloggt.");
  }
}

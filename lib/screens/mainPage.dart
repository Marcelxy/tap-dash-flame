import 'package:tap_dash_flame/screens/registerPage.dart';
import 'package:tap_dash_flame/screens/highscorePage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.teal.shade300,
          child: Icon(Icons.play_arrow),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 9,
          elevation: 25,
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // linke Icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: Colors.teal.shade300,
                          ),
                          Text(
                            "Profil",
                            style: TextStyle(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showHighscore(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.equalizer,
                            color: Colors.teal.shade300,
                          ),
                          Text(
                            "Rangliste",
                            style: TextStyle(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // rechte Icons
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.dashboard,
                            color: Colors.teal.shade300,
                          ),
                          Text(
                            "Level",
                            style: TextStyle(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.teal.shade300,
                          ),
                          Text(
                            "Konfig",
                            style: TextStyle(
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
}

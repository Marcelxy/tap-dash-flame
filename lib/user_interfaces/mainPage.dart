import 'package:tap_dash_flame/user_interfaces/registerPage.dart';
import 'package:tap_dash_flame/user_interfaces/profilPage.dart';
import 'package:tap_dash_flame/user_interfaces/highscorePage.dart';
import 'package:tap_dash_flame/user_interfaces/levelPage.dart';
import 'package:tap_dash_flame/user_interfaces/shopPage.dart';
import 'package:tap_dash_flame/user_interfaces/SettingsPage.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  int currentPage = 0;
  final List<Widget> pages = [
    ProfilPage(),
    HighscorePage(),
    LevelPage(),
    SettingsPage(),
  ];

  Widget currentScreen = HighscorePage();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap Dash',
      home: Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
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
                      onPressed: () => _showProfilPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: currentPage == 0 ? Colors.black : Colors.teal.shade300,
                          ),
                          Text(
                            "Profil",
                            style: TextStyle(
                              color: currentPage == 0 ? Colors.black : Colors.teal.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showHighscorePage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.equalizer,
                            color: currentPage == 1 ? Colors.black : Colors.teal.shade300,
                          ),
                          Text(
                            "Rangliste",
                            style: TextStyle(
                              color: currentPage == 1 ? Colors.black : Colors.teal.shade300,
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
                      onPressed: () => _showLevelPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.dashboard,
                            color: currentPage == 2 ? Colors.black : Colors.teal.shade300,
                          ),
                          Text(
                            "Level",
                            style: TextStyle(
                              color: currentPage == 2 ? Colors.black : Colors.teal.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _showShopPage(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.shop_two,
                            color: currentPage == 3 ? Colors.black : Colors.teal.shade300,
                          ),
                          Text(
                            "Shop",
                            style: TextStyle(
                              color: currentPage == 3 ? Colors.black : Colors.teal.shade300,
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

  void _showProfilPage() {
    setState(() {
      currentScreen = ProfilPage();
      currentPage = 0;
    });
    print("Spieler wechselt zu seinem Benutzerprofil.");
  }

  void _showHighscorePage() {
    setState(() {
      currentScreen = HighscorePage();
      currentPage = 1;
    });
    print("Spieler wechselt zur Ranglistenansicht.");
  }

  void _showLevelPage() {
    setState(() {
      currentScreen = LevelPage();
      currentPage = 2;
    });
    print("Spieler wechselt zur Level Auswahl.");
  }

  void _showShopPage() {
    setState(() {
      currentScreen = ShopPage();
      currentPage = 3;
    });
    print("Spieler wechselt zum Shop.");
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

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:tap_dash_flame/user_interfaces/settingsPage.dart';
import 'package:tap_dash_flame/user_interfaces/registerPage.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings), onPressed: () => _showSettingsPage()),
          IconButton(
              icon: Icon(Icons.input), onPressed: () => _showRegisterPage()),
        ],
      ),
    );
  }

  void _showSettingsPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
    print("Spieler wechselt zu Einstellungen.");
  }

  void _showRegisterPage() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    // TODO Page Stack im Hintergrund entfernen! Navigator.pushNamedAndRemoveUntil(context, "/logout", (_) => false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
    print("Spieler wechselt zum Registrierungsbildschirm.");
  }
}

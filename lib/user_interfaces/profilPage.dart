import 'package:flutter/material.dart';

import 'package:tap_dash_flame/user_interfaces/SettingsPage.dart';

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
        ],
      ),
    );
  }

  void _showSettingsPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
    print("Spieler wechselt zu Einstellungen.");
  }
}

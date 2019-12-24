import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HighscorePage extends StatefulWidget {
  @override
  _HighscorePageState createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rangliste',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rangliste'),
        ),
        body: Container(
          child: BookList(),
        ),
      ),
    );
  }
}

class BookList extends StatelessWidget {
  Query playerReference = Firestore.instance
      .collection('player')
      .orderBy('exp', descending: true)
      .limit(10);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: playerReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  //leading: Icon(),
                  title: new Text(document['playerName']),
                  subtitle: new Text(document['exp'].toString()),
                );
              }).toList(),
            );
        }
      },
    );
  }
}

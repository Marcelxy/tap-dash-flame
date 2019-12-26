import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/util.dart';

import 'package:tap_dash_flame/game_enigne/tapDashGame.dart';

class LevelPage extends StatefulWidget {
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level Auswahl'),
      ),
      body: GridView.builder(
          itemCount: 50,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Card(
                    elevation: 5.0,
                    child: new Container(
                      alignment: Alignment.center,
                      child: new Text('Level ${index + 1}'),
                    ),
                  )),
              onTap: () => _startLevel(),
            );
          }),
    );
  }

  void _startLevel() async {
    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    TapDashGame game = TapDashGame();
    runApp(game.widget);
    print("Spieler wechselt zum Spielbildschirm.");
  }
}

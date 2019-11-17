import 'main.dart';
import 'package:flutter/material.dart';
import 'package:play_games/play_games.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
                  child: _playGamesRegistrationButton(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: _googleRegistrationButton(),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _playGamesRegistrationButton() => OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    highlightElevation: 5,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_play_games_logo.png"), height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Anmelden mit Play Games',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
    ),
  );

  Widget _googleRegistrationButton() => OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
      signInWithGoogle().whenComplete(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MyAppHome();
        }));
      });
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    highlightElevation: 5,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/images/google_logo.png"), height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Anmelden mit Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      )
    ),
  );

  // TODO
  void _playGamesRegistration(BuildContext context) async {
    SigninResult result = await PlayGames.signIn();
    if (result.success) {
      await PlayGames.setPopupOptions();
    } else {
      // TODO Fehlermeldung ausgeben!
    }
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }
}

import 'package:tap_dash_flame/user_interfaces/mainPage.dart';
import 'package:tap_dash_flame/datastructures/player.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'package:progress_dialog/progress_dialog.dart';

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
  final FacebookLogin fbLogin = FacebookLogin();

  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    progressDialog.style(message: "Login...");
    return Scaffold(
      appBar: AppBar(
        title: Text('Tap Dash'),
        automaticallyImplyLeading: false,
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
                  onPressed: () => _signInWithGoogle(),
                  darkMode: true,
                  borderRadius: 10,
                  text: 'Anmelden mit Google',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: FacebookSignInButton(
                  onPressed: () => _facebookLogin(),
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
    FirebaseUser currentUser;
    try {
      progressDialog.show();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      currentUser = (await _auth.signInWithCredential(credential)).user;
      if (currentUser != null) {
        _createPlayerInDatabase(currentUser);
        print("Angemeldet über Google mit " + currentUser.email);
        print(currentUser);
        Future.delayed(Duration(seconds: 1)).then((value) {
          progressDialog.hide().whenComplete(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          });
        });
        return currentUser;
      }
    } catch (e) {
      print(e);
      return currentUser;
    }
    return null;
  }

  Future<FirebaseUser> _facebookLogin() async {
    FirebaseUser currentUser;
    fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    try {
      progressDialog.show();
      final FacebookLoginResult facebookLoginResult =
          await fbLogin.logIn(['email']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        currentUser = await _auth.currentUser();
        _createPlayerInDatabase(user);
        print("Angemeldet über Facebook mit " + user.email);
        print(user);
        Future.delayed(Duration(seconds: 1)).then((value) {
          progressDialog.hide().whenComplete(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          });
        });
        return currentUser;
      }
    } catch (e) {
      print(e);
      return currentUser;
    }
    return null;
  }

  void _createPlayerInDatabase(FirebaseUser user) {
    Player player = new Player(user.email, user.displayName);
    Firestore.instance.collection('player').document(user.uid).setData({
      'email': player.email,
      'playerName': player.playerName,
      'exp': player.exp,
      'coins': player.coins
    });
  }
}

import 'package:flutter/material.dart';
import 'package:league_plus/services/FireStore/auth.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('Sign in'),
            onPressed: () async {
              await AuthService().signInWithEmailAndPassword('bartosz.maciej.litwa@gmail.com', 'test1234');
            },
          ),

          FlatButton(
            child: Text('Register in'),
            onPressed: () async {
              await AuthService().registerWithEmailAndPassword('bartosz.maciej.litwa@gmail.com', 'test1234');
            },
          ),
        ],
      ),
    );
  }
}
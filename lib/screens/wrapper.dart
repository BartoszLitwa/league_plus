import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:league_plus/screens/authentication/login.dart';
import 'package:league_plus/screens/league_main/league_main.dart';
import 'package:league_plus/services/FireStore/auth.dart';
import 'package:league_plus/services/FireStore/database.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Not connected'); 
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(backgroundColor: Theme.of(context).accentColor),
            ); 
          default:
            if(snapshot.hasData && !snapshot.data.isAnonymous) {
              DatabaseService.uid = snapshot.data.uid;
              return LeagueMain();
            }
            else
              return Login();
        }
      }
    );
  }
}
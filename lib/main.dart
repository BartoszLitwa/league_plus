import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:league_plus/models/user.dart';
import 'package:league_plus/screens/wrapper.dart';
import 'package:league_plus/services/FireStore/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: FlutterEasyLoading(
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
          ),
      )
    );
  }
}
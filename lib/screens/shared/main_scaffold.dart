import 'package:flutter/material.dart';
import 'package:league_plus/screens/home/drawer.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final String title;

  MainScaffold({this.body, this.title});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      drawer: MainDrawer(),

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          
        ],
      ),

      body: widget.body,
    );
  }
}
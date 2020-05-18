import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.grey[800],
  filled: true,
  hintText: 'Search a summoer',
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),

  suffixIcon: FlatButton(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: -20),
    onPressed: () {
      print('Searching');
    },
    child: Icon(Icons.search, color: Colors.white),
  ) 
);
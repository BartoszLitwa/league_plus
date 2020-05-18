import 'package:flutter/material.dart';
import 'package:league_plus/constants/url_routes.dart';
import 'package:league_plus/services/league_api.dart';
import 'package:league_plus/services/league_classes/classes.dart';

class SearchTextField extends StatefulWidget {
  final Color white;
  final Color dark;

  SearchTextField({this.white, this.dark});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String _currentText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: true,
      decoration: InputDecoration(
        fillColor: Colors.grey[800],
        filled: true,
        hintText: 'Search a summoner',
        hintStyle: TextStyle(
          color: widget.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: widget.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: widget.white, width: 2),
        ),

        suffixIcon: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: -20),
          onPressed: () async {
            await searchForSummoner(_currentText);
          },
          child: Icon(Icons.search, color: widget.white),
        ) 
      ),

      style: TextStyle(color: widget.white),

      onChanged: (val) => _currentText = val,
      
      onSubmitted: (String val) async {
        await searchForSummoner(val);
      },
    );
  }

  Future searchForSummoner(String val) async {
    if(val.isEmpty)
      return;

    Summoner sum = await LeagueService.getSummoner(Regions.eune, val);

    var text = await LeagueService.getSummonersChampion(Regions.eune, sum.id);

    print(LeagueService.getSummonerIcon(sum.profileIconId));

    print(text);
  }
}
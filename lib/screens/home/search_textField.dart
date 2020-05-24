import 'package:flutter/material.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';

class SearchTextField extends StatefulWidget {
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
          color: Theme.of(context).accentColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2),
        ),

        suffixIcon: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: -20),
          onPressed: () async {
            await searchForSummoner(_currentText);
          },
          child: Icon(Icons.search, color: Theme.of(context).accentColor),
        ) 
      ),

      style: TextStyle(color: Theme.of(context).accentColor),

      onChanged: (val) => _currentText = val,
      
      onSubmitted: (String val) async {
        await searchForSummoner(val);
      },
    );
  }

  Future searchForSummoner(String val) async {
    if(val == null || val.isEmpty)
      return;

    var sum = await LeagueService.getSummonerByName(Regions.eune, val);

    if(sum == null)
      return null;

    Navigator.pushNamed(context, '/searchSummoner', arguments: FavouriteSummoner(region: Regions.eune, summonerID: val));
  }
}
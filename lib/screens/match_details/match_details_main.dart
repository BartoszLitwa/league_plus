import 'package:flutter/material.dart';
import 'package:league_plus/models/match_details_info.dart';
import 'package:league_plus/screens/match_details/match_details_analysis.dart';
import 'package:league_plus/screens/match_details/mtach_details_overview.dart';
import 'package:league_plus/screens/shared/main_scaffold.dart';

class MatchDetails extends StatefulWidget {
  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final MatchDetailsInfo match = ModalRoute.of(context).settings.arguments;

    return MainScaffold(
      title: 'League of Legends',
      body: Container(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                height: 52.0,
                child: new TabBar(
                  indicatorColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.info),
                      text: "Overview",
                    ),
                    Tab(
                      icon: Icon(Icons.show_chart),
                      text: "Analysis",
                    ),
                    Tab(
                      icon: Icon(Icons.expand_more),
                      text: "THREE",
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                MatchDetailsOverview(match: match),
                MatchDetailsAnalysis(match: match),
                MyBody("TAB THREE CONTENT"),
              ],
            ),
          ),
        )
      )
    );
  }
}

class MyBody extends StatelessWidget {
  final String title;

  MyBody(this.title);

  final mySnackBar = SnackBar(
    content: Text(
      "Hello There!",
      style: TextStyle(color: Colors.white),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: Text(title + "  Click me"),
              onPressed: () => {Scaffold.of(context).showSnackBar(mySnackBar)}),
        ],
      ),
    );
  }
}
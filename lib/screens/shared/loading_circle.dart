import 'package:flutter/material.dart';

class LoadingRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      ),
    ); 
  }
}
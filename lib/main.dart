import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'constants/theme.dart';
import 'views/home.dart';

void main() => runApp(ChristmasList());

class ChristmasList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Christmas List',
      theme: ThemeData(
        primarySwatch: AppTheme.primary,
      ),
      home: Home(title: 'Christmas Helper'),
    );
  }
}
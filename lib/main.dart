import 'package:flutter/material.dart';
import 'package:test_flutter_2/homepage.dart';
import 'package:test_flutter_2/loginpage.dart';
import 'package:test_flutter_2/profilepage.dart';
import 'package:test_flutter_2/searchpage.dart';
import 'package:test_flutter_2/signuppage.dart';
import 'package:test_flutter_2/profilepage.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/searchportal.dart';
import 'package:test_flutter_2/editprofile.dart';
import 'package:test_flutter_2/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeApp(),
    );
  }
}

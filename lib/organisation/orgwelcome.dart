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
import 'package:test_flutter_2/organisation/signuppage.dart';
import 'package:test_flutter_2/organisation/loginpage.dart';


/*void main() {
  runApp(WelcomeApp());
}*/

class OrgWelcomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
          child: Column(
            children :<Widget> [
              Container(
                width:150,
                height:150
              ),

              Text(
              '',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
              ),
            ),

          Container(
                width:250,
                height:60
              ),

            ElevatedButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OSignUpApp()),
                  );
              },
              child: Text('ORGANISATION SIGN UP'),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(99, 81, 160, 1.0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),

            Container(
                height:10
              ),
              
            ElevatedButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OLogInApp()),
                  );
              },
              child: Text('ORGANISATION LOG IN'),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(99, 81, 160, 1.0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),

            Container(
                height:10
              ),
              
            ElevatedButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => WelcomeApp()),
                  );
              },
              child: Text('GO BACK'),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(99, 81, 160, 1.0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),

            ]
          ),
        ),
      ),
    );
  }
}

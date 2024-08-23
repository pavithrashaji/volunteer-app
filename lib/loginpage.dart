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
import 'package:test_flutter_2/organisation/orgwelcome.dart';
import 'package:test_flutter_2/userwelcome.dart';

/*void main() {
  runApp(LogInApp());
}*/

class LogInApp extends StatelessWidget {
  final APIService apiService = APIService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> logIn(BuildContext context) async {
      try {
            if(emailController.text.isEmpty || passwordController.text.isEmpty)
            {
                showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('ERROR'),
                  content: Text('Missing fields!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
            else{
              String pass1 = await apiService.loginUser(emailController.text);

              if(pass1 == passwordController.text) {
                int id1 = await apiService.retrieveUserID(emailController.text);
                Navigator.push(context, MaterialPageRoute (
                    builder: (context) => HomeApp(id1: id1)),
                    );
              }
              else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('ERROR'),
                    content: Text('E-Mail and password do not match!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            
                }
          
        } catch (e) {
          
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('ERROR'),
              content: Text('Failed to log in!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
        
      }
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
              'LOG IN',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
              ),
            ),

            Container(
                width:250,
                height:30
              ),
            
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'E-Mail',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            Container(
              width: 300,
              height: 55,
              padding: const EdgeInsets.only(top: 5.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter e-mail',
                ),
              ),
            ),

            Container(
                width:250,
                height:20
              ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            
            Container(
              width: 300,
              height: 55,
              padding: const EdgeInsets.only(top: 5.0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter password',
                ),
              ),
            ),

            Container(
                width:250,
                height:40
              ),

            TextButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => SignUpApp()),
                  );
              },
              child: Text('Don\'t have an account?'),
            ),

            ElevatedButton(
              onPressed: () {
                logIn(context);
              },
              child: Text('LOG IN'),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(99, 81, 160, 1.0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),

            ElevatedButton(
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute (
                  builder: (context) => UserWelcomeApp()),
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

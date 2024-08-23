import 'package:flutter/material.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/organisation/loginpage.dart';
import 'package:test_flutter_2/organisation/signuppage.dart';
import 'package:test_flutter_2/organisation/profilepage.dart';
import 'package:test_flutter_2/organisation/addopp.dart';
import 'package:test_flutter_2/organisation/api_service.dart';
import 'package:test_flutter_2/organisation/orgwelcome.dart';
import 'package:test_flutter_2/userwelcome.dart';


/*void main() {
  runApp(SignUpApp());
}*/

class OSignUpApp extends StatelessWidget {
  final OAPIService apiService = OAPIService();

  final nameController = TextEditingController();
  final postcodeController = TextEditingController();
  final websiteController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    if (passwordController.text == confirmPasswordController.text) {
      try {
          if(nameController.text.isEmpty || emailController.text.isEmpty || websiteController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty)
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
            await apiService.createOrg({
              "name": nameController.text,
              "email": emailController.text,
              "website": websiteController.text,
              "password": passwordController.text,
              "description": "" 
            });

            int id1 = await apiService.retrieveOrgID(emailController.text);
          
        Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OProfileApp(id1: id1, pending: true)),
                  ); }
        
      } catch (e) {
        
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('ERROR'),
            content: Text('Failed to sign up!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
    
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('ERROR'),
          content: Text('Passwords do not match!'),
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
              Container(height: 20),
              Text(
              'ORGANISATION',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),

              Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
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
                'Name',
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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter name',
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
                'Website',
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
                controller: websiteController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter website',
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
                height:20
              ),

              Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'Confirm Password',
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
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                ),
              ),
            ),

            Container(
                width:250,
                height:20
              ),

            TextButton(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OLogInApp()),
                  );
              },
              child: Text('Already have an account?'),
            ),

            ElevatedButton(
              onPressed: () { 
                signUp(context);
                
              },
              child: Text('SIGN UP'),
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
                  builder: (context) => OrgWelcomeApp()),
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

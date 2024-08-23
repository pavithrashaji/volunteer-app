import 'package:flutter/material.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/organisation/loginpage.dart';
import 'package:test_flutter_2/organisation/signuppage.dart';
import 'package:test_flutter_2/organisation/profilepage.dart';
import 'package:test_flutter_2/organisation/addopp.dart';
import 'package:test_flutter_2/organisation/api_service.dart';

/*void main() {
  runApp(EditApp());
}*/

class OEditApp extends StatefulWidget {
  final int id1;
  OEditApp({required this.id1}) ;

  @override
  _EditAppState createState() => _EditAppState();
}

class _EditAppState extends State<OEditApp> {

static String name = "";
static String website = "";
static String email = "";
static String description = "";
static String password = "";

  final OAPIService apiService = OAPIService();

  final nameController = TextEditingController();
  final websiteController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final descriptionController= TextEditingController();

  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeData();

  }

  Future<void> _initializeData() async {
    await retrieveDetails();
  }
  
  Future<void> retrieveDetails() async {
    print("Name: " + name);
    name = await apiService.retrieveOrg(widget.id1, 'name');
    print("Name1: " + name);
    website = await apiService.retrieveOrg(widget.id1, 'website');
    print("Name1: " + website);
    email = await apiService.retrieveOrg(widget.id1, 'email');
    print("Name1: " + email);
    description = await apiService.retrieveOrg(widget.id1, 'description');
    print("Name1: " + description);
    password = await apiService.retrieveOrg(widget.id1, 'password');
    print("Name: " + password);
  }

  Future<void> updateUserDetails() async {
    if(nameController.text.isNotEmpty)
      name = nameController.text;
    if(emailController.text.isNotEmpty)
      email = emailController.text;
    if(websiteController.text.isNotEmpty)
      website = websiteController.text;
    if(descriptionController.text.isNotEmpty)
      description = descriptionController.text;
    if(passwordController.text.isNotEmpty)
      password = passwordController.text;
    print(name + email + website + password + description);

    await apiService.updateOrg(widget.id1, {
              "name": name,
              "email": email,
              "website": website,
              "description": description,
              "password": password,
            });
    print("Name1: " + name);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: FutureBuilder<void> (
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return _buildContent();
            }
          },
         ),
      ),
    );
  }
  
  Widget _buildContent() {         
       return Center(
          child: Column(
            children :<Widget> [
              /*Container(
                height:20
              ),*/
              Text(
              'Update Profile',
              style: TextStyle(
                  fontSize: 35.0,
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
                  labelText: name,
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
                  labelText: website,
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
                  labelText: email,
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
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '********',
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
                'Description',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            
            Container(
              width: 300,
              height: 130,
              padding: const EdgeInsets.only(top: 5.0),
              child: TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),

            Container(
                width:250,
                height:40
              ),

              ElevatedButton(
              onPressed: () {
                updateUserDetails();
                Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OProfileApp(id1: widget.id1, pending: true)),
                  );
              },
              child: Text('SAVE CHANGES'),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(99, 81, 160, 1.0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),

          Container(
                width:250,
                height:40
              ),

            //BOTTOM MENU
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
                
                /*IconButton(
                              icon: Icon(Icons.search),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => SearchPApp(id1: widget.id1)),
                          );
                              },
                            ),*/

                IconButton(
                              icon: Icon(Icons.add_circle_outline_outlined),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => OAddApp(id1: widget.id1)),
                          );
                              },
                            ),
                
                IconButton(
                              icon: Icon(Icons.account_circle_rounded),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => OProfileApp(id1: widget.id1, pending: true)),
                          );
                              },
                            ),

                IconButton(
                              icon: Icon(Icons.logout),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => WelcomeApp()),
                          );
                              },
                            ),
            
            ],
          ),
          
            /*Container(
              height: 30
            ),*/
          
            ]
          ),
    );
  }
}

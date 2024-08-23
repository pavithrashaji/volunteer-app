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

/*void main() {
  runApp(EditApp());
}*/

class EditApp extends StatefulWidget {
  final int id1;
  EditApp({required this.id1}) ;

  @override
  _EditAppState createState() => _EditAppState();
}

class _EditAppState extends State<EditApp> {

static String name = "";
static String postcode = "";
static String contact = "";
static String email = "";
static String uni = "";
static String password = "";

  final APIService apiService = APIService();

  final nameController = TextEditingController();
  final postcodeController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final uniController= TextEditingController();

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
    name = await apiService.retrieveUser(widget.id1, 'name');
    print("Name1: " + name);
    postcode = await apiService.retrieveUser(widget.id1, 'postcode');
    print("Name1: " + postcode);
    contact = await apiService.retrieveUser(widget.id1, 'contact_no');
    print("Name1: " + contact);
    email = await apiService.retrieveUser(widget.id1, 'email');
    print("Name1: " + email);
    uni = await apiService.retrieveUser(widget.id1, 'university');
    print("Name: " + uni);
    password = await apiService.retrieveUser(widget.id1, 'password');
    print("Name: " + password);
  }

  Future<void> deleteAccount() async {
    await apiService.deleteUser(widget.id1);
  }
  Future<void> updateUserDetails() async {
    if(nameController.text.isNotEmpty)
      name = nameController.text;
    if(emailController.text.isNotEmpty)
      email = emailController.text;
    if(contactController.text.isNotEmpty)
      contact = contactController.text;
    if(postcodeController.text.isNotEmpty)
      postcode = postcodeController.text;
    if(uniController.text.isNotEmpty)
      uni = uniController.text;
    if(passwordController.text.isNotEmpty)
      password = passwordController.text;
    print(name + email + postcode + contact + uni + password);

    await apiService.updateUser(widget.id1, {
              "name": name,
              "email": email,
              "postcode": postcode,
              "contact_no": contact,
              "password": password,
              "university": uni, 
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
                'Region',
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
                controller: postcodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: postcode,
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
                'Contact Number',
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
                controller: contactController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: contact,
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
                'University',
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
                controller: uniController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: uni,
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

              ElevatedButton(
              onPressed: () {
                updateUserDetails();
                Navigator.push(context, MaterialPageRoute (
                  builder: (context) => ProfileApp(id1: widget.id1, pending: true)),
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

            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('WARNING'),
                      content: Text('Are you sure you want to delete your account?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            //DELETE OPERATION HEREEEE
                            deleteAccount();
                            Navigator.push(context, MaterialPageRoute (
                              builder: (context) => WelcomeApp()),
                              );
                          },
                          child: Text('DELETE'),
                        ),
                      ],
                    ),
                );
              },
              child: Text('DELETE ACCOUNT'),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),

          Container(
                width:250,
                height:20
              ),

            //BOTTOM MENU
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
                
                IconButton(
                              icon: Icon(Icons.search),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => SearchPApp(id1: widget.id1)),
                          );
                              },
                            ),

                IconButton(
                              icon: Icon(Icons.home),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => HomeApp(id1: widget.id1)),
                          );
                              },
                            ),
                
                IconButton(
                              icon: Icon(Icons.account_circle_rounded),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => ProfileApp(id1: widget.id1, pending: true)),
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_flutter_2/homepage.dart';
import 'package:test_flutter_2/loginpage.dart';
import 'package:test_flutter_2/organisation/api_service.dart';
import 'package:test_flutter_2/profilepage.dart';
import 'package:test_flutter_2/searchpage.dart';
import 'package:test_flutter_2/signuppage.dart';
import 'package:test_flutter_2/profilepage.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/searchportal.dart';
import 'package:test_flutter_2/editprofile.dart';
import 'package:test_flutter_2/api_service.dart';
import 'package:test_flutter_2/displayindividual.dart';


/*void main() {
  runApp(ProfileApp());
}*/


class ProfileApp extends StatefulWidget {

  final int id1;
  final bool pending;
  ProfileApp({required this.id1, required this.pending}) ;

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  static String name = "";
  static String uni = "";
  static dynamic completionRate = null;
  static dynamic rating = null;
  static List<dynamic> applications = [];
  static bool pending = true;

  final APIService apiService = APIService();
  final OAPIService apiService1 = OAPIService();

  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeData();

  }

  Future<void> _initializeData() async {
    await retrieveName();
    await retrieveUni();
    await retrieveApps();
  }
  
  Future<void> retrieveName() async {
    name = await apiService.retrieveUser(widget.id1, 'name');
    print("Name: " + name);
  }

  Future<void> retrieveUni() async {
    uni = await apiService.retrieveUser(widget.id1, 'university');
    completionRate = await apiService.retrieveUser(widget.id1, 'completion_rate');
    rating = await apiService.retrieveUser(widget.id1, 'avg_rating');
    print("Name: " + uni);
  }

  Future<void> retrieveApps() async {
    applications = await apiService1.retrieveUserAppList(widget.id1);
    print(applications);
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
       return Align(
          child: Column(
            children :<Widget> [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            
            Text(
              name,
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            Text(
              uni,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            Row(children: [
              Text(
              'Completion Rate: ',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
              Text(
              (completionRate!=null ? completionRate.round().toString()+"%" : "N/A"),
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),],),
            
            Row(children: [
              Text(
              'Perfomance Score: ',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              (rating!=null ? rating.toString() : "N/A"),
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),],),

            TextButton.icon(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => EditApp(id1: widget.id1)),
                  );
              },
              
              icon: Icon(Icons.edit), 
              
              label: Text(
                'Update profile',
                style: TextStyle(
                  fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            
            )
            ],),
            ],),

         SizedBox(height: 15),

        Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(
              onPressed: () {
                pending = true;
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileApp(id1: widget.id1, pending: pending),
                ),
                );
              },
              child: Text('Applications'),
              style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: pending ? Color.fromRGBO(99, 81, 160, 0.5) : Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54, width: 0.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
            ),


            ElevatedButton(
              onPressed: () {
                pending = false;
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileApp(id1: widget.id1, pending: pending),
                ),
              );
              },
              child: Text('Volunteer History'),
              style: 
                    ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: pending ? Colors.white : Color.fromRGBO(99, 81, 160, 0.5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54, width: 0.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              ),
            ),
        ],),

        Expanded(child: ApplicationPage(applications: applications, id1: widget.id1, pending: pending)),

        Container(height: 15),

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
                          builder: (context) => ProfileApp(id1: widget.id1, pending: widget.pending)),
                          );
                              },
                            ),

                IconButton(
                              icon: Icon(Icons.logout),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                name = "";
                                uni = "";
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => WelcomeApp()),
                          );
                              },
                            ),
            
            ],
          ),
          
            Container(
              height: 30
            ),

            ],
        ),
       );
  }
}

class ApplicationPage extends StatefulWidget {
  final List<dynamic> applications;
  final int id1;
  final bool pending;
  ApplicationPage({required this.applications, required this.id1, required this.pending});

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<ApplicationPage> {
  final List<Widget> _containers = [];

   void _addContainer (BuildContext context) {
  setState(() {
    if(widget.applications.isEmpty) {
      _containers.add (
        Container(
          width: MediaQuery.of(context).size.width/1.1,
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
                  color: Color.fromRGBO(99, 81, 160, 1),
                  width: 0.5, // Adjust the width as needed
                  ),
                  borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text( 
            'NO APPLICATIONS YET!'
          ),
        ),
      );
    }
    
    for (var application in widget.applications) {
      if(widget.pending == false && application['completedStatus']==1)
      {
        _containers.add (
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndDisplayApp(id1: widget.id1, id2: application['opportunity']['id'], appStatus: "Completed", c1: 103, c2: 165, c3: 78),
                ),
              );
            },
          child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide.none,
                bottom: BorderSide(
                  color: Color.fromRGBO(99, 81, 160, 1),
                  width: 0.5, // Adjust the width as needed
                ),
                left: BorderSide.none, // No left border
                right: BorderSide.none, // No right border
              ),
          ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['opportunity']['title'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              Text(
                application['opportunity']['company'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),


              Row (
                children: [
                  Text(
                    'Rating: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      ),
                  ),

                  Text(
                    '5',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      ),
                  ),
                ],
              ),


         ],)
         ),
        ),
      );
      }
      else if(widget.pending == true)
      {
      String appStatus = 'Pending';
      Color c = Color.fromRGBO(49, 105, 154, 1.0);
      int c1 = 49;
      int c2 = 105;
      int c3 = 154;
      if(application['status'] == 1)
      {
        appStatus = 'Accepted';
        c = Color.fromRGBO(103, 165, 78, 1.0);
        c1 = 103;
        c2 = 165;
        c3 = 78;
      }
      else if(application['status'] == -1)
      {
        appStatus = 'Rejected';
        c = Color.fromRGBO(183, 51, 54, 1.0);
        c1 = 183;
        c2 = 51;
        c3 = 54;
      }
      else if(application['status'] == 2)
      {
        appStatus = 'Confirmed';
        c = Color.fromRGBO(103, 165, 78, 1.0);
        c1 = 103;
        c2 = 165;
        c3 = 78;
      }
      else if(application['status'] == -2)
      {
        appStatus = 'Withdrawn';
        c = Color.fromRGBO(183, 51, 54, 1.0);
        c1 = 183;
        c2 = 51;
        c3 = 54;
      }

      if(application['completedStatus'] == 1)
      {
        appStatus = 'Completed';
        c1 = 103;
        c2 = 165;
        c3 = 78;
      }
      else if(application['completedStatus'] == -1)
      {
        appStatus = 'No Show';
        c = Color.fromRGBO(183, 51, 54, 1.0);
        c1 = 183;
        c2 = 51;
        c3 = 54;
      }
      
      if(appStatus == "Accepted")
      {
      _containers.add (
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndDisplayApp(id1: widget.id1, id2: application['opportunity']['id'], appStatus: appStatus, c1: c1, c2: c2, c3: c3),
                ),
              );
            },
          child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide.none,
                bottom: BorderSide(
                  color: Color.fromRGBO(99, 81, 160, 1),
                  width: 0.5, // Adjust the width as needed
                ),
                left: BorderSide.none, // No left border
                right: BorderSide.none, // No right border
              ),
          ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['opportunity']['title'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              Text(
                application['opportunity']['company'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),


              Row (
                children: [
                  Text(
                    'Status: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      ),
                  ),

                  Text(
                    appStatus,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: c,
                      ),
                  ),
                ],
              ),

              Container(height:10),

              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


            Container(
              height: 36,
              width: 150,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(103, 165, 78, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(103, 165, 78, 0.5),
                    ),
                      child: TextButton.icon(
              onPressed: () {
                confirmApplication(application['id']);
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => ProfileApp(id1: widget.id1, pending: widget.pending)),
                  );
              },
              
              icon: Icon(Icons.check, size: 20, color: Color.fromRGBO(103, 165, 78, 1),), 
              
              label: Text(
                'CONFIRM',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            ),),

            Container(width:15),
            Container(
              height: 36,
              width: 150,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(183, 51, 54, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(183, 51, 54, 0.5),
                    ),
                      child: TextButton.icon(
              onPressed: () {
                withdrawApplication(application['id']);
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => ProfileApp(id1: widget.id1, pending: widget.pending)),
                  );
              },
              
              icon: Icon(Icons.close, size: 20, color: Color.fromRGBO(183, 51, 54, 1),), 
              
              label: Text(
                'WITHDRAW',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            ),),
                ],
              ),


         ],)
         ),
        ),
      );
      }

      else
      {
        _containers.add (
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndDisplayApp(id1: widget.id1, id2: application['opportunity']['id'], appStatus: appStatus, c1: c1, c2: c2, c3: c3),
                ),
              );
            },
          child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide.none,
                bottom: BorderSide(
                  color: Color.fromRGBO(99, 81, 160, 1),
                  width: 0.5, // Adjust the width as needed
                ),
                left: BorderSide.none, // No left border
                right: BorderSide.none, // No right border
              ),
          ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['opportunity']['title'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              Text(
                application['opportunity']['company'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),


              Row (
                children: [
                  Text(
                    'Status: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      ),
                  ),

                  Text(
                    appStatus,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: c,
                      ),
                  ),
                ],
              ),
         ],)
         ),
        ),
        );
      }
    } 
  }
  });
   }

  @override
  void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
      _addContainer(context);
    });
  }
  
  final OAPIService apiService = OAPIService();

  Future<void> confirmApplication(int id) async {
    await apiService.updateAppStatus(id, {
              "status": 2
            });
  }

  Future<void> withdrawApplication(int id) async {
    await apiService.updateAppStatus(id, {
              "status": -2
            });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded (
        child: SingleChildScrollView(
        child: Column(
          children: _containers,
        ),
      ),
        ),
      ],
    );
  }
 }

  
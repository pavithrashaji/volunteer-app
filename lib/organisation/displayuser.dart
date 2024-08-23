import 'package:flutter/material.dart';
import 'package:test_flutter_2/organisation/api_service.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/api_service.dart';
import 'package:test_flutter_2/displayindividual.dart';
import 'package:test_flutter_2/organisation/profilepage.dart';
import 'package:test_flutter_2/organisation/addopp.dart';




/*void main() {
  runApp(ProfileApp());
}*/


class UserApp extends StatefulWidget {

  final int id1;
  final int id2;

  UserApp({required this.id1, required this.id2}) ;

  @override
  _UserAppState createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
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
    name = await apiService.retrieveUser(widget.id2, 'name');
    print("Name: " + name);
  }

  Future<void> retrieveUni() async {
    uni = await apiService.retrieveUser(widget.id2, 'university');
    completionRate = await apiService.retrieveUser(widget.id2, 'completion_rate');
    rating = await apiService.retrieveUser(widget.id2, 'avg_rating');
    print("Name: " + uni);
  }

  Future<void> retrieveApps() async {
    applications = await apiService1.retrieveUserAppList(widget.id2);
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
            ],),
            ],),

         SizedBox(height: 15),

        Container(
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 0.5), 
            borderRadius: BorderRadius.circular(5.0), 
            color: Color.fromRGBO(99, 81, 160, 0.5),
          ),
            child: Text(
              'Volunteer History',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                ),
            ),
        ),

        Expanded(child: ApplicationPage(applications: applications, id1: widget.id1, pending: pending)),

        Container(height: 15),

        //BOTTOM MENU
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
      if(application['completedStatus']==1)
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

  
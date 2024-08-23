import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/organisation/loginpage.dart';
import 'package:test_flutter_2/organisation/signuppage.dart';
import 'package:test_flutter_2/organisation/profilepage.dart';
import 'package:test_flutter_2/organisation/addopp.dart';
import 'package:test_flutter_2/organisation/editprofile.dart';
import 'package:test_flutter_2/organisation/api_service.dart';
import 'package:test_flutter_2/organisation/displayapp.dart';

/*void main() {
  runApp(ProfileApp());
}*/


class OProfileApp extends StatefulWidget {

  final int id1;
  final bool pending;
  
  OProfileApp({required this.id1, required this.pending}) ;

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<OProfileApp> {
  static String name = "";
  static String website = "";
  static String description = "";
  static List<dynamic> opportunities = [];
  static bool pending = true;

  final OAPIService apiService = OAPIService();

  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeData();
  }

  Future<void> _initializeData() async {
    await retrieveOpportunity();
    await retrieveName();
    await retrieveWebsite();
    await retrieveDescription();
  }
  
  Future<void> retrieveOpportunity() async {
    opportunities = await apiService.retrieveOpp(widget.id1.toString());
    print(opportunities);
  }

  Future<void> retrieveName() async {
    name = await apiService.retrieveOrg(widget.id1, 'name');
  }

  Future<void> retrieveWebsite() async {
    website = await apiService.retrieveOrg(widget.id1, 'website');
  }

  Future<void> retrieveDescription() async {
    description = await apiService.retrieveOrg(widget.id1, 'description');
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
            //crossAxisAlignment: CrossAxisAlignment.end,
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
                //fontFamily: 
              ),
              overflow: TextOverflow.ellipsis,
            ),
            
            Text(
              website,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                
                //fontFamily: 
              ),
            ),

            TextButton.icon(
              onPressed: () {
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OEditApp(id1: widget.id1)),
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

            
            ),
            Container(
              width: MediaQuery.of(context).size.width/1.2,
            child: Text(
              description,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                //fontFamily: 
              ),
              
              textAlign: TextAlign.justify,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),),

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
                  builder: (context) => OProfileApp(id1: widget.id1, pending: pending),
                ),
                );
              },
              child: Text('Pending Events'),
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
                  builder: (context) => OProfileApp(id1: widget.id1, pending: pending),
                ),
              );
              },
              child: Text('Completed Events'),
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
        Expanded(child: ApplicationPage(id1: widget.id1, opportunities: opportunities, pending: pending,)),

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
  final List<dynamic> opportunities;
  final int id1;
  final bool pending;
  final Color s = Color.fromRGBO(1, 1, 1, 1);
  
  ApplicationPage({required this.id1, required this.opportunities, required this.pending});

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<ApplicationPage> {
  final List<Widget> _containers = [];

  Map<String, Color> sdgColors = {
      'No Poverty': Color.fromRGBO(211, 58, 67, 1.0),
			'Zero Hunger': Color.fromRGBO(213, 169, 79, 1.0),
			'Good Health and Well-being': Color.fromRGBO(98, 159, 81, 1.0),
			'Quality Education': Color.fromRGBO(183, 51, 54, 1.0),
			'Gender Equality': Color.fromRGBO(220, 79, 58, 1.0),
			'Clean Water and Sanitation': Color.fromRGBO(93, 188, 226, 1.0),
			'Affordable and Clean Energy': Color.fromRGBO(242, 198, 70, 1.0),
			'Decent Work and Economic Growth': Color.fromRGBO(149, 42, 69, 1.0),
			'Industry, Innovation, and Infrastructure': Color.fromRGBO(226, 114, 64, 1.0),
			'Reduced Inequality': Color.fromRGBO(206, 50, 129, 1.0),
			'Sustainable Cities and Communities': Color.fromRGBO(235, 161, 70, 1.0),
			'Responsible Consumption and Production': Color.fromRGBO(183, 143, 64, 1.0),
			'Climate Action': Color.fromRGBO(80, 126, 76, 1.0),
			'Life Below Water': Color.fromRGBO(73, 149, 207, 1.0),
			'Life on Land': Color.fromRGBO(103, 165, 78, 1.0),
			'Peace, Justice, and Strong Institutions': Color.fromRGBO(49, 105, 154, 1.0),
			'Partnerships for the Goals': Color.fromRGBO(36, 72, 104, 1.0)
  };

   void _addContainer (BuildContext context) {
  setState(() {
    for (var opportunity in widget.opportunities) {
      DateTime enddate = DateTime.parse(opportunity['end_date']);
      print(enddate);
      print(enddate.compareTo(DateTime.now()));

      if((widget.pending == true && enddate.compareTo(DateTime.now()) == 1) || 
      (widget.pending == false && enddate.compareTo(DateTime.now()) <=0))
      {
      _containers.add (
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayApp(id1: widget.id1, id2: opportunity['id'], pending: widget.pending),
                ),
              );
            },
          child: 
         Container(
          width: MediaQuery.of(context).size.width/1.1,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
                  color: Color.fromRGBO(99, 81, 160, 1),
                  width: 0.5, // Adjust the width as needed
                  ),
                  borderRadius: BorderRadius.circular(5.0),
          ),

          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        
              Text(
                opportunity['title'],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              Container(height:5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: sdgColors[opportunity['sdgoal1']] ?? Colors.black, width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: sdgColors[opportunity['sdgoal1']]?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5),
                    ),
                      child: Text(
                        " " + opportunity['sdgoal1'] + " ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          ),
                      ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: sdgColors[opportunity['sdgoal2']] ?? Colors.black, width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: sdgColors[opportunity['sdgoal2']]?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5),
                    ),
                      child: Text(
                        " " + opportunity['sdgoal2'] + " ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          ),
                      ),
                  ),
                ],
              ),
            
            Container(height:8.0),
            Row(
              children: [
                Icon(Icons.business, size: 20.0),
                Container(width: 10),
                Text(
                    opportunity['company'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic, 
                      ),
                  ),
              ],),

              Row(
                children: [
                  Icon(Icons.timer, size: 20.0),
                Container(width: 10),
              Text(
                'Duration: ' + opportunity['duration'].toString() + ' weeks',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  ),
              ),
                ],),
         ],)
         ),
        ),
      ); //}
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
      /*FloatingActionButton(
        onPressed: _addContainer,
        child: Icon(Icons.add),
      ),*/
      ],
    );
  }
 }

  
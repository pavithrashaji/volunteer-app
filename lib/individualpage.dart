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
import 'package:test_flutter_2/organisation/api_service.dart';



/*void main() {
  runApp(IndividualApp());
}*/

class IndividualApp extends StatefulWidget {

  final int id1;
  final int id2;
  final Map<String, Color> sdgColors = {
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
  
  IndividualApp({required this.id1, required this.id2});

  @override
  _IndividualAppState createState() => _IndividualAppState();
}

class _IndividualAppState extends State<IndividualApp> {
  static String title = "";
  static String company = "";
  static int duration = 0;
  static String description = "";
  static String sdgoal1 = "";
  static String sdgoal2 = "";

  final OAPIService apiService = OAPIService();

  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeData();

  }

  Future<void> _initializeData() async {
    await retrieveOpportunity();
  }
  
  Future<void> retrieveOpportunity() async {
    print(widget.id1.toString() + widget.id2.toString());
    title = await apiService.retrieveOppOne(widget.id2, 'title');
    company = await apiService.retrieveOppOne(widget.id2, 'company');
    duration = await apiService.retrieveOppOne(widget.id2, 'duration');
    description = await apiService.retrieveOppOne(widget.id2, 'description');
    sdgoal1 = await apiService.retrieveOppOne(widget.id2, 'sdgoal1');
    sdgoal2 = await apiService.retrieveOppOne(widget.id2, 'sdgoal2');
    
    print("Hello");
    print(title + company + duration.toString() + description);
  }

  Future<void> apply() async {
    await apiService.createApplication({
      "user": widget.id1,
      "opportunity": widget.id2,
      "status": 0,
    });
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
              Container(
                height:MediaQuery.of(context).size.height/1.55,
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
                title,
                //'ABC',
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
                      border: Border.all(color: widget.sdgColors[sdgoal1] ?? Colors.black, width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: widget.sdgColors[sdgoal1]?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5),
                    ),
                      child: Text(
                        " " + sdgoal1 + " ",
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
                      border: Border.all(color: widget.sdgColors[sdgoal2] ?? Colors.black, width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: widget.sdgColors[sdgoal2]?.withOpacity(0.5) ?? Colors.black.withOpacity(0.5),
                    ),
                      child: Text(
                        " " + sdgoal2 + " ",
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
                    company,
                    //'ABC',
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
                'Duration: ' + duration.toString() + ' weeks',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  ),
              ),
                ],),
              Container (height:10),
              Text(
                description,
                //'ABCDEF',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  ),
                textAlign: TextAlign.justify,
                softWrap: true,
                overflow: TextOverflow.visible,
                maxLines: null,
              ),
         ],)
         ),

         Container(
                width:250,
                height:30
              ),

              ElevatedButton(
              onPressed: () {
                apply();
                Navigator.push(context, MaterialPageRoute (
                  builder: (context) => HomeApp(id1: widget.id1)),
                  );
              },
              child: Text('APPLY'),
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

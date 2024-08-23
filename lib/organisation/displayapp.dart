import 'package:flutter/material.dart';
import 'package:test_flutter_2/welcomepage.dart';
import 'package:test_flutter_2/organisation/loginpage.dart';
import 'package:test_flutter_2/organisation/signuppage.dart';
import 'package:test_flutter_2/organisation/profilepage.dart';
import 'package:test_flutter_2/organisation/addopp.dart';
import 'package:test_flutter_2/organisation/api_service.dart';
import 'package:test_flutter_2/organisation/displayuser.dart';

/*void main() {
  runApp(IndividualApp());
}*/

class DisplayApp extends StatefulWidget {

  final int id1;
  final int id2;
  final bool pending;
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
  
  DisplayApp({required this.id1, required this.id2, required this.pending});

  @override
  _DisplayAppState createState() => _DisplayAppState();
}

class _DisplayAppState extends State<DisplayApp> {
  static String title = "";
  static String company = "";
  static int duration = 0;
  static String description = "";
  static List<dynamic> applications = [];
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
    await retrieveApplications();
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

  Future<void> retrieveApplications() async {
    applications = await apiService.retrieveOppAppList(widget.id2);
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
                      width: 0.5, 
                  ),
                  borderRadius: BorderRadius.circular(5.0),
          ),

          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
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
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),

              Container(height:25),

              Container(
                alignment: Alignment.center,
              margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(169, 169, 169, 0.3),
                    ),
              child: Text(
                      'APPLICANTS',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        ),
                    ),
              ),
              Expanded(child: ApplicationPage(applications: applications, id1: widget.id1, id2: widget.id2, pending: widget.pending)),

         ],)
                ),

              Container(
                      width:250,
                      height:30
                    ),

              ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute (
                  builder: (context) => OProfileApp(id1: widget.id1, pending: true)),
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
                
          Container(
                width:250,
                height:40
              ),

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
          
            /*Container(
              height: 30
            ),*/
          
           ]
          ),
    );
  }
}

class ApplicationPage extends StatefulWidget {
  List<dynamic> applications;
  final int id1;
  final int id2;
  final bool pending;
  ApplicationPage({required this.applications, required this.id1, required this.id2, required this.pending});

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<ApplicationPage> {
  final List<Widget> _containers = [];
  int rating = 0;
  final List<int> ratings = [0,1,2,3,4,5];
  final OAPIService apiService = OAPIService();

  void _setRating(int? value) {
    setState(() {
      print("Value : " + value.toString());
      rating = value!;
      print("Rating :" + rating.toString());
    });
  }

  Future<void> updateRating(int id, int? value, BuildContext context) async {

    await apiService.updateAppStatus(id, {
        "rating": value
      });

    Navigator.push(context, MaterialPageRoute (
                  builder: (context) => DisplayApp(id1: widget.id1, id2: widget.id2, pending: widget.pending)),
                  );
  }

   void _addContainer (BuildContext context) {
  setState(() {
    if(widget.applications.isEmpty) {
      _containers.add (
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
          child: Text( 
            'NO APPLICANTS YET!'
          ),
        ),
      );
    }
    for (var application in widget.applications) {
      if (application['status']==0 && widget.pending==true)
      {
      _containers.add (
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserApp(id1: widget.id1, id2: application['user']['id']),
                ),
              );
            },
          child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(99, 81, 160, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                    ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['user']['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              
              Text(
                application['user']['university'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),

              Container(height: 10),


              Row (
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

            Container(
              height: 36,
              width: 120,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(103, 165, 78, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(103, 165, 78, 0.5),
                    ),
                      child: TextButton.icon(
              onPressed: () {
                acceptApplication(application['id']);
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => DisplayApp(id1: widget.id1, id2: widget.id2, pending: widget.pending)),
                  );
              },
              
              icon: Icon(Icons.check, size: 20, color: Color.fromRGBO(103, 165, 78, 1),), 
              
              label: Text(
                'ACCEPT',
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
              width: 120,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(183, 51, 54, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(183, 51, 54, 0.5),
                    ),
                      child: TextButton.icon(
              onPressed: () {
                rejectApplication(application['id']);
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => DisplayApp(id1: widget.id1, id2: widget.id2, pending: widget.pending)),
                  );
              },
              
              icon: Icon(Icons.close, size: 20, color: Color.fromRGBO(183, 51, 54, 1),), 
              
              label: Text(
                'REJECT',
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
      ); }

      //Completing applications
      else if (application['status']==2 && widget.pending==false)
      {
        if(application['completedStatus']==0)
        {
      _containers.add (
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserApp(id1: widget.id1, id2: application['user']['id']),
                ),
              );
            },
          child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(99, 81, 160, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                    ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['user']['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              
              Text(
                application['user']['university'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),

              Container(height: 10),


              Row (
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

            Container(
              height: 36,
              width: 140,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(103, 165, 78, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(103, 165, 78, 0.5),
                    ),
                      child: TextButton.icon(
              onPressed: () {
                completeApplication(application['id']);
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => DisplayApp(id1: widget.id1, id2: widget.id2, pending: widget.pending)),
                  );
              },
              
              icon: Icon(Icons.check, size: 20, color: Color.fromRGBO(103, 165, 78, 1),), 
              
              label: Text(
                'COMPLETE',
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
              width: 140,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(183, 51, 54, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(183, 51, 54, 0.5),
                    ),
                      child: TextButton.icon(
              onPressed: () {
                noShowApplication(application['id']);
              Navigator.push(context, MaterialPageRoute (
                  builder: (context) => DisplayApp(id1: widget.id1, id2: widget.id2, pending: widget.pending)),
                  );
              },
              
              icon: Icon(Icons.close, size: 20, color: Color.fromRGBO(183, 51, 54, 1),), 
              
              label: Text(
                'NO SHOW',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            ),),
                ],
              ),

          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "ADD RATING: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600, 
                  ),
              ),

              Container (
                width: MediaQuery.of(context).size.width/4,
                child: DropdownButton<int>(
                value: application['rating'] ?? 0,
                icon: Icon(Icons.expand_more, size: 20),
                isExpanded: true,
                onChanged: (value) => {updateRating(application['id'], value, context)},
                items: ratings.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
          ), 
            ],), 

          //Container(height: 20),

         ],)
         ),
      ),
      ); 
      }

      else if (application['completedStatus']==1)
      {
        _containers.add (
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(99, 81, 160, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                    ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['user']['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              
              Text(
                application['user']['university'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),

              Container(height: 10),

            Container(
              height: 36,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(103, 165, 78, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(103, 165, 78, 0.5),
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 20, color: Color.fromRGBO(103, 165, 78, 1)),
                          Container(width:15),
                          Text(
                              'COMPLETED',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
            ),

            Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "ADD RATING: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600, 
                  ),
              ),

              Container (
                width: MediaQuery.of(context).size.width/4,
                child: DropdownButton<int>(
                value: application['rating'] ?? 0,
                icon: Icon(Icons.expand_more, size: 20),
                isExpanded: true,
                onChanged: (value) => {updateRating(application['id'], value, context)},
                items: ratings.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
          ), 
            ],),
                

          //Container(height: 20),

         ],)
         ),
        
      ); 
      }
      else if (application['completedStatus']==-1)
      {
        _containers.add (
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(99, 81, 160, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                    ),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                application['user']['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  ),
              ),
              
              Text(
                application['user']['university'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic, 
                  ),
              ),

              Container(height: 10),

            Container(
              height: 36,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(183, 51, 54, 1), width: 0.5), 
                      borderRadius: BorderRadius.circular(5.0), 
                      color: Color.fromRGBO(183, 51, 54, 0.5),
                    ),
                      child: Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, size: 20, color: Color.fromRGBO(183, 51, 54, 1)),
                          Container(width:15),
                            Text(
                                  'NO SHOW',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                            ),
                        ],
                      )
            ),

            Row( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "ADD RATING: ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600, 
                  ),
              ),

              Container (
                width: MediaQuery.of(context).size.width/4,
                child: DropdownButton<int>(
                value: rating,
                icon: Icon(Icons.expand_more, size: 20),
                isExpanded: true,
                onChanged: (value) => {updateRating(application['id'], value, context)},
                items: ratings.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
          ), 
            ],),
                

          //Container(height: 20),

         ],)
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

  Future<void> acceptApplication(int id) async {
    await apiService.updateAppStatus(id, {
              "status": 1
            });
  }

  Future<void> rejectApplication(int id) async {
    await apiService.updateAppStatus(id, {
              "status": -1
            });
  }

  Future<void> completeApplication(int id) async {
    await apiService.updateAppStatus(id, {
              "completedStatus": 1
            });
  }

  Future<void> noShowApplication(int id) async {
    await apiService.updateAppStatus(id, {
              "completedStatus": -1
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
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

class OAddApp extends StatefulWidget {
  final int id1;
  OAddApp({required this.id1});

  @override
  _OAddAppState createState() => _OAddAppState();
}

class _OAddAppState extends State<OAddApp> {
  static String title = "";
  static String company = "";
  static int duration = 0;
  static String description = "";
  static int opp_id = 0;
  String sdgoal1 = "";
  String sdgoal2 = "";
  final List<String> SDGoals = [
    'No Poverty',
    'Zero Hunger',
    'Good Health and Well-being',
    'Quality Education',
    'Gender Equality',
    'Clean Water and Sanitation',
    'Affordable and Clean Energy',
    'Decent Work and Economic Growth',
    'Industry, Innovation, and Infrastructure',
    'Reduced Inequality',
    'Sustainable Cities and Communities',
    'Responsible Consumption and Production',
    'Climate Action',
    'Life Below Water',
    'Life on Land',
    'Peace, Justice, and Strong Institutions',
    'Partnerships for the Goals'
  ];

  @override
  void initState() {
    super.initState();
    sdgoal1 = "";
  }

  final OAPIService apiService = OAPIService();

  final titleController = TextEditingController();
  //final companyController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> createOpportunity() async {
    if (titleController.text.isNotEmpty) title = titleController.text;
    if (durationController.text.isNotEmpty) {
      final durationtext = durationController.text;
      duration = int.tryParse(durationtext) ?? 0;
    }
    if (descriptionController.text.isNotEmpty)
      description = descriptionController.text;
    print(title + company + description);
    print(duration);

    company = await apiService.retrieveOrg(widget.id1, 'name');
    opp_id = await apiService.createOpp({
      "title": title,
      "company": company,
      "companyid": widget.id1,
      "duration": 2,
      "description": description,
      "start_date": _startDate.toString().substring(0, 10),
      "end_date": _endDate.toString().substring(0, 10)
    });

    String newSDgoal1 = await apiService.retrieveOppOne(opp_id, 'sdgoal1');
    String newSDgoal2 = await apiService.retrieveOppOne(opp_id, 'sdgoal2');

    setState(() {
      sdgoal1 = newSDgoal1;
      sdgoal2 = newSDgoal2;
    });

    print("Name1: " + title);
    print("Name1: " + sdgoal1);
    print("Name1: " + sdgoal2);
  }

  Future<void> updateSDGoal(int? a, int id, String? value, BuildContext context) async {
    print("a: " + a.toString());
    print("id: " + id.toString());
    print("value: " + value!);
    if (a == 1) {
      setState(() {
        sdgoal1 = value;
      });
      //apiService.updateOpportunity(id, {"sdgoal1": value});
    } else if (a == 2) {
      setState(() {
        sdgoal2 = value;
      });
      //await apiService.updateOpportunity(id, {"sdgoal2": value});
    }
  }

  Future<void> updateOppSDG(int id, String sdgoal1, String sdgoal2, BuildContext context) async {
    await apiService.updateOpportunity(id, {"sdgoal1": sdgoal1, "sdgoal2": sdgoal2});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OProfileApp(id1: widget.id1, pending: true),
      ),
    );
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _endDate = _startDate;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: _startDate,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
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
            children: <Widget>[
              Text(
                'ADD NEW',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'VOLUNTEER WORK',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Container(width: 250, height: 20),

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 70.0),
                child: Text(
                  'Title',
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
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter job title",
                  ),
                ),
              ),

              Container(width: 250, height: 20),

              /*Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 70.0),
                child: Text(
                  'Duration (in weeks)',
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
                child: TextFormField(
                  controller: durationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter duration",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    final intValue = int.tryParse(value);
                    if (intValue == null) {
                      return 'Please enter a valid integer';
                    }
                    return null;
                  },
                ),
              ),

              Container(width: 250, height: 20),*/

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 70.0),
                child: Text(
                  'Start date',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5, 
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.only(top: 5.0),
                child: TextButton(
                  onPressed: () => _selectDate1(context),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _startDate == DateTime.now()
                          ? ''
                          : _startDate.toString().substring(0, 10),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),

              Container(width: 250, height: 20),

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 70.0),
                child: Text(
                  'End date',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5, // Adjust the width as needed
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.only(top: 5.0),
                child: TextButton(
                  onPressed: () => _selectDate2(context),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _endDate == DateTime.now()
                          ? ''
                          : _endDate.toString().substring(0, 10),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),

              Container(width: 250, height: 20),

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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter region",
                  ),
                ),
              ),

              Container(width: 250, height: 20),

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

              Container(width: 250, height: 20),

              ElevatedButton(
                onPressed: () async {
                  await createOpportunity();
                  print("SDGOAL 1: " + sdgoal1);
                  print("SDGOAL 2: " + sdgoal2);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirmation'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SD Goals identified are:', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                          Container (height: 15),
                          Text(
                            "Goal 1: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton<String>(
                              value: sdgoal1,
                              icon: Icon(Icons.expand_more, size: 20),
                              isExpanded: true,
                              onChanged: (value) => updateSDGoal(1, opp_id, value, context),
                              items: SDGoals.map(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          Container (height: 15),
                          Text(
                            "Goal 2: ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton<String>(
                              value: sdgoal2,
                              icon: Icon(Icons.expand_more, size: 20),
                              isExpanded: true,
                              onChanged: (value) async { await updateSDGoal(2, opp_id, value, context);},
                              items: SDGoals.map(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed:() => updateOppSDG(opp_id, sdgoal1, sdgoal2, context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                child: Text('SAVE CHANGES'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(99, 81, 160, 1.0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),

              Container(width: 250, height: 30),

              //BOTTOM MENU
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*IconButton(
                    icon: Icon(Icons.search),
                    color: Color.fromRGBO(99, 81, 160, 1.0),
                    iconSize: 35.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPApp(id1: widget.id1),
                        ),
                      );
                    },
                  ),*/

                  IconButton(
                    icon: Icon(Icons.add_circle_outline_outlined),
                    color: Color.fromRGBO(99, 81, 160, 1.0),
                    iconSize: 35.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OAddApp(id1: widget.id1),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle_rounded),
                    color: Color.fromRGBO(99, 81, 160, 1.0),
                    iconSize: 35.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OProfileApp(id1: widget.id1, pending: true),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    color: Color.fromRGBO(99, 81, 160, 1.0),
                    iconSize: 35.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeApp(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              /*Container(
                height: 30
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

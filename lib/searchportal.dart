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
  runApp(SearchPApp());
}*/

Widget createButton(BuildContext context, String name, int a, int b, int c, int id1, int sdg) {
  return ElevatedButton(
              onPressed: () {
              // add functionalityyyyy
              Navigator.push(context, MaterialPageRoute (
                          builder: (context) => SearchApp(id1: id1, searchText: "", a: 2, b: sdg)),
                          );
              },
              child: Text(name),
              style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(a, b, c, 0.8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              )
        ); 
}



class SearchPApp extends StatelessWidget {

  final int id1;
  SearchPApp({required this.id1});
  static String searchText = "";
  final searchTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Align(
          child: Column(
            children :<Widget> [
        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(99, 81, 160, 1),
                  width: 0.8, // Adjust the width as needed
                  ),
                  borderRadius: BorderRadius.circular(5.0),
            ),
            height: 45,
            child: TextField(
              controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              ),
            onSubmitted: (String value) {
            // Navigate to another page when submitted
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchApp(id1: id1, searchText: searchTextController.text, a: 1, b: 0)),
            );
          },
    
            ),
        ),

        Container(height: 15),

        Expanded(child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createButton(context, 'NO POVERTY', 211, 58, 67, id1, 1),
              createButton(context, 'ZERO HUNGER', 213, 169, 79, id1, 2),
              createButton(context, 'GOOD HEALTH AND WELL-BEING', 98, 159, 81, id1, 3),
              createButton(context, 'QUALITY EDUCATION', 183, 51, 54, id1, 4),
              createButton(context, 'GENDER EQUALITY', 220, 79, 58, id1, 5),
              createButton(context, 'CLEAN WATER AND SANITATION', 93, 188, 226, id1, 6),
              createButton(context, 'AFFORDABLE AND CLEAN ENERGY', 242, 198, 70, id1, 7),
              createButton(context, 'DECENT WORK AND ECONOMIC GROWTH', 149, 42, 69, id1, 8),
              createButton(context, 'INDUSTRY, INNOVATION AND INFRASTRUCTURE', 226, 114, 64, id1, 9),
              createButton(context, 'REDUCED INEQUALITIES', 206, 50, 129, id1, 10),
              createButton(context, 'SUSTAINABLE CITIES AND COMMUNITIES', 235, 161, 70, id1, 11),
              createButton(context, 'RESPONSIBLE CONSUMPTION AND PRODUCTION', 183, 143, 64, id1, 12),
              createButton(context, 'CLIMATE ACTION', 80, 126, 76, id1, 13),
              createButton(context, 'LIFE BELOW WATER', 73, 149, 207, id1, 14),
              createButton(context, 'LIFE ON LAND', 103, 165, 78, id1, 15),
              createButton(context, 'PEACE, JUSTICE AND STRONG INSTITUTIONS', 49, 105, 154, id1, 16),
              createButton(context, 'PARTNERSHIPS FOR THE GOALS', 36, 72, 104, id1, 17),
          ],),
        ),),
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
                          builder: (context) => SearchPApp(id1: id1)),
                          );
                              },
                            ),

                IconButton(
                              icon: Icon(Icons.home),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => HomeApp(id1: id1)),
                          );
                              },
                            ),
                

                IconButton(
                              icon: Icon(Icons.account_circle_rounded),
                              color: Color.fromRGBO(99, 81, 160, 1.0),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute (
                          builder: (context) => ProfileApp(id1: id1, pending: true)),
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
      ),
      ),
    );
  }
}


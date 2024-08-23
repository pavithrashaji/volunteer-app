# test_flutter_2

The relevant contents of this project are organised as follows:
.
├── README.md
├── lib
│   ├── api_service.dart
│   ├── displayindividual.dart
│   ├── editprofile.dart
│   ├── homepage.dart
│   ├── individualpage.dart
│   ├── loginpage.dart
│   ├── main.dart
│   ├── organisation
│   │   ├── addopp.dart
│   │   ├── api_service.dart
│   │   ├── displayapp.dart
│   │   ├── displayuser.dart
│   │   ├── editprofile.dart
│   │   ├── loginpage.dart
│   │   ├── orgwelcome.dart
│   │   ├── profilepage.dart
│   │   └── signuppage.dart
│   ├── profilepage.dart
│   ├── searchpage.dart
│   ├── searchportal.dart
│   ├── signuppage.dart
│   ├── userwelcome.dart
│   └── welcomepage.dart
├── pubspec.yaml
├── requirements.txt
└── volunteer
    ├── count_vect.pkl
    ├── db.sqlite3
    ├── manage.py
    ├── model.pkl
    ├── volunteer
    │   ├── __init__.py
    │   ├── asgi.py
    │   ├── settings.py
    │   ├── urls.py
    │   └── wsgi.py
    └── volunteer1app
        ├── __init__.py
        ├── admin.py
        ├── apps.py
        ├── migrations
        ├── models.py
        ├── serializers.py
        ├── tests.py
        ├── urls.py
        └── views.py

lib contains all the front-end Flutter files for the application. Files for organisation's end are stored under lib/organisation.
volunteer contains all the back-end Django files for the application. 

Files under lib:
 - api_service.dart : Used to create API requests for all user related operations.
 - displayindividual.dart : Used to display individual opportunities.
 - editprofile.dart : Used to edit user profile.
 - homepage.dart : Home page for user to view volunteer opportunities.
 - individualpage.dart : Used to display individual opportunities with APPLY options.
 - loginpage.dart : Used to log in as a user.
 - main.dart : Used to start up the application.
 - profilepage.dart : Used to view user profile.
 - searchpage.dart : Used to search for specific opportunities.
 - searchportal.dart : Used to search with SD Goal.
 - signuppage.dart : Used to sign up as a new user.
 - userwelcome.dart : Welcome page for user containing sign up and log in options.


Files under lib/organisation:
 - api_service.dart : Used to create API requests for all organisation, opportunity and application related operations.
 - addopp.dart : Used to add opportunities.
 - displayapp.dart : Used to display specific opportunities with their applicants.
 - displayuser.dart: Used to view individual user profiles.
 - editprofile.dart : Used to edit organisation profile.
 - loginpage.dart : Used to log in as an organisation.
 - profilepage.dart : Used to view organisation profile.
 - signuppage.dart : Used to sign up as a new organisation.
 - orgwelcome.dart : Welcome page for organisation containing sign up and log in options.

Files under volunteer:
 - count_vect.pkl : Used to create TF-IDF matrix
 - model.pkl : Object storing the model data
 - db.sqlite3 : SQLite3 database

Files under volunteer/volunteer1app:
 - models.py : Used to store models of the application. 
 - serializers.py : Used to store serializers of the application. 
 - views.py : Used to store views of the application. 
 - urls.py : Used to store URL paths of the application. 


Files under volunteer/volunteer:
 - settings.py : Used to define database engine as SQLite3.
 - urls.py : Used to store initial URL path of the application.
















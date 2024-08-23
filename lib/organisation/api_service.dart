import 'dart:convert';
import 'package:http/http.dart' as http;

class OAPIService {
  static const String baseURL = "http://127.0.0.1:8000/api/organisations";
  static const String oppURL = "http://127.0.0.1:8000/api/opportunities";
  static const String appURL = "http://127.0.0.1:8000/api/applications";

 
  Future<List<dynamic>> fetchOrg() async {
    final response = await http.get(Uri.parse('$baseURL/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load organisations');
    }
  }

  Future<String> loginOrg(String email) async {
    final response = await http.get(
      Uri.parse('$baseURL/by-email/?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> organisation = jsonDecode(response.body);
      if(organisation.containsKey('password')) {
          return organisation['password'];
      }
      else {
        throw Exception('No password stored.');
      }

    }
    else if (response.statusCode == 404) {
      throw Exception('Email does not exist.');
    }
    else {
      throw Exception('Failed to login.');
    }
  }

  Future<int> retrieveOrgID(String email) async {
    final response = await http.get(
      Uri.parse('$baseURL/by-email/?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> organisation = jsonDecode(response.body);
      if(organisation.containsKey('id')) {
          return organisation['id'];
      }
      else {
        throw Exception('No ID stored.');
      }

    }
    else if (response.statusCode == 404) {
      throw Exception('Email does not exist.');
    }
    else {
      throw Exception('Failed to retrieve ID.');
    }
  }

  Future<void> createOrg(Map<String, dynamic> organisation) async {
    final response = await http.post(
      Uri.parse('$baseURL/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(organisation),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create organisation profile');
    }
  }

  Future<void> updateOrg(int id, Map<String, dynamic> organisation) async {
    final response = await http.put(
      Uri.parse('$baseURL/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(organisation),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update organisation profile');
    }
  }

  Future<dynamic> retrieveOrg(int id1, String s1) async {
    final response = await http.get(
      Uri.parse('$baseURL/$id1/'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> organisation = jsonDecode(response.body);
      if(organisation.containsKey(s1)) {
          return organisation[s1];
      }
      else {
        throw Exception('No ID stored.');
      }

    }
    else if (response.statusCode == 404) {
      throw Exception('Organisation profile does not exist.');
    }
    else {
      throw Exception('Failed to retrieve ID.');
    }
  }

  // Future<int> updateCompletionUser() async {
  //   final response = await http.get(
  //     Uri.parse('$baseURL/$id1/'),
  //     headers: {'Content-Type': 'application/json'},
  //   );
    
  // }


  Future<void> deleteOrg(int id) async {
    final response = await http.delete(Uri.parse('$baseURL$id/'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete organisation profile');
    }
  }

  Future<int> createOpp(Map<String, dynamic> opportunity) async {

    print(opportunity);
    final response = await http.post(
      Uri.parse('$oppURL/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(opportunity),
    );
    
    if (response.statusCode == 201) {
      Map<String, dynamic> opp = jsonDecode(response.body);
      return opp['id'];
    }
    
    else {
      throw Exception('Failed to create opportunity');
    }
  }

  Future<List<int>> searchOpp(String query) async {
    final response = await http.get(Uri.parse('$oppURL/search/?title=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<int>(); 
    } else {
      throw Exception('Failed to load opportunities');
    }
  }

  Future<List<dynamic>> retrieveOpp(String id1) async {
    final response = await http.get(
      Uri.parse('$oppURL/by-companyid/?companyid=$id1'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 404) {
      return [];
    }
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to retrieve opportunities.');
    }
  }

  Future<List<dynamic>> retrieveOppList(List<int> id1) async {
    List<dynamic> oppList1 = [];
    dynamic response;
    for (var i in id1) {
    response = await http.get(
      Uri.parse('$oppURL/$i'),
      headers: {'Content-Type': 'application/json'},
    );
    oppList1.add(jsonDecode(response.body));}
    
    if (response.statusCode == 200) {
      return oppList1;
    }
    else {
      throw Exception('Failed to retrieve opportunities.');
    }
  }

  Future<dynamic> retrieveOppOne(int id1, String s1) async {
    final response = await http.get(
      Uri.parse('$oppURL/$id1/'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> opportunity = jsonDecode(response.body);
      if(opportunity.containsKey(s1)) {
          return opportunity[s1];
      }
      else {
        throw Exception('No ID stored.');
      }
    }
    else {
      throw Exception('Failed to retrieve opportunity.');
    }
  }

  Future<List<dynamic>> retrieveOppAll() async {
    final response = await http.get(
      Uri.parse('$oppURL/'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 404) {
      return [];
    }
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to retrieve opportunities.');
    }
  }
  Future<void> createApplication(Map<String, dynamic> application) async {
    final response = await http.post(
      Uri.parse('$appURL/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(application),
    );
    print(application);
    
    if (response.statusCode != 201) {
      throw Exception('Failed to apply');
    }
  }

  Future<void> updateAppStatus(int id, Map<String, dynamic> application) async {
    final response = await http.put(
      Uri.parse('$appURL/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(application),
    );
    print(application);
    
    if (response.statusCode != 200) {
      throw Exception('Failed to update status');
    }
  }

  Future<void> updateOpportunity(int id, Map<String, dynamic> opportunity) async {
    final response = await http.patch(
      Uri.parse('$oppURL/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(opportunity),
    );
    print(opportunity);
    
    if (response.statusCode != 200) {
      throw Exception('Failed to update SD Goal');
    }
  }


  Future<List<dynamic>> retrieveUserAppList(int id1) async {
    dynamic response = await http.get(
      Uri.parse('$appURL/by-user/?user=$id1'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 404) {
      return [];
    }
    List<dynamic> appList1 = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return appList1;
    }
    else {
      throw Exception('Failed to retrieve applications.');
    }
  }

  Future<List<dynamic>> retrieveOppAppList(int id1) async {
    dynamic response = await http.get(
      Uri.parse('$appURL/by-opportunity/?opportunity=$id1'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 404) {
      return [];
    }
    List<dynamic> appList1 = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return appList1;
    }
    else {
      throw Exception('Failed to retrieve applications.');
    }
  }
}



import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseURL = "http://127.0.0.1:8000/api/users";

 
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseURL/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<String> loginUser(String email) async {
    final response = await http.get(
      Uri.parse('$baseURL/by-email/?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      if(user.containsKey('password')) {
          return user['password'];
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

  Future<int> retrieveUserID(String email) async {
    final response = await http.get(
      Uri.parse('$baseURL/by-email/?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      if(user.containsKey('id')) {
          return user['id'];
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

  Future<void> createUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse('$baseURL/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(int id, Map<String, dynamic> user) async {
    final response = await http.put(
      Uri.parse('$baseURL/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<dynamic> retrieveUser(int id1, String s1) async {
    final response = await http.get(
      Uri.parse('$baseURL/$id1/'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      if(user.containsKey(s1)) {
          return user[s1];
      }
      else {
        throw Exception('No ID stored.');
      }

    }
    else if (response.statusCode == 404) {
      throw Exception('User does not exist.');
    }
    else {
      throw Exception('Failed to retrieve ID.');
    }
  }


  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseURL/$id/'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}



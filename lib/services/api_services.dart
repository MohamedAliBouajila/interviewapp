import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:interviewapp/models/projectperson.dart';

import '../models/person.dart';
import '../models/project.dart';

class ApiServices {
  final String baseUrl = "http://63.250.52.98:9305";
  final String token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsImF1dGgiOlt7ImF1dGhvcml0eSI6IlJPTEVfQ0xJRU5UIn1dLCJpYXQiOjE3MDg0Mzc4MzUsImV4cCI6MTcwOTAzNzgzNX0.IFzC2a74BV2MvgTXDRISr8GJxwMbBIGzp3EzpCLFRU4";
  Future<List<Person>> fetchEmployes() async {
    final response = await http.get(Uri.parse('$baseUrl/persons'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Person> employees =
          data.map((person) => Person.fromJson(person)).toList();
      return employees;
    } else {
      throw Exception("failed to load");
    }
  }

  Future fetchEmployeWithId(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/persons/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("failed to load");
    }
  }

  Future createEmploye(Person person) async {
  final List<Person> employees = await fetchEmployes();
  int? lastId = 0;
  if (employees.isNotEmpty) {
    lastId = employees.map((person) => person.idperson).reduce((a, b) => a! > b! ? a : b);
  }
  person.idperson = lastId ?? 0 + 1;

 final String personson = jsonEncode(person.toJson());

  final response = await http.post(
    Uri.parse('$baseUrl/persons/new'),
    body: personson,
    headers: <String, String>{HttpHeaders.contentTypeHeader: 'application/json',
     HttpHeaders.authorizationHeader: 'Bearer $token'},
  );

 

  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Expired or invalid JWT token");
  }
}


Future updateEmploye(Person person) async {
 final String projectJson = jsonEncode(person.toJson());
    final response = await http.put(
        Uri.parse('$baseUrl/persons/upuserr/${person.idperson}'),
        body: projectJson,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
         HttpHeaders.authorizationHeader: 'Bearer $token'});
 
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("failed to load");
    }
  }

  Future deleteEmploye(String id) async {
    final response = await http.delete(
        Uri.parse('$baseUrl/persons/$id'),);
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception("failed to load");
    }
  }

  Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Project> projects =
          data.map((project) => Project.fromJson(project)).toList();
      return projects;
    } else {
      throw Exception("Failed to load projects");
    }
  }

  Future<void> addProject(Project project) async {
    final List<Project> projects = await fetchProjects();
  int lastId = 0;
  
  if (projects.isNotEmpty) {
    lastId = projects.map((project) => project.idpro).reduce((a, b) => a > b ? a : b);
  }
  project.idpro = lastId + 1;
  final String projectJson = jsonEncode(project.toJson());

  final response = await http.post(Uri.parse('$baseUrl/projects/new'),
      body: projectJson, 
      headers: <String, String>{
        HttpHeaders.contentTypeHeader:'application/json',    
          HttpHeaders.authorizationHeader: 'Bearer $token'
      }
  );

  if (response.statusCode == 201) {
    return;
  } else {
    throw Exception("Failed to add project");
  }
}

Future<List<ProjectPerson>> fetchProjectPersons() async {
  final response = await http.get(Uri.parse('$baseUrl/projectsdone/all'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((json) => ProjectPerson.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load project persons');
  }
}

Future<ProjectPerson> createProjectPerson(ProjectPerson projectPerson) async {

  final response = await http.post(
    Uri.parse('$baseUrl/projectsdone/create'),
    headers: <String, String>{
     HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token'
    },
    body: jsonEncode(projectPerson.toJson()),
  );
  if (response.statusCode == 200) {
    return ProjectPerson.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create project person');
  }
}
}

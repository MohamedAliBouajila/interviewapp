import 'package:http/http.dart';

class Project {
  int idpro;
  String nom;
  String date;
  String description;
  double latitude;
  double longitude;

  Project({
    required this.idpro,
    required this.nom,
    required this.date,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Project.fromJson(Map<String, dynamic> project) {
    return Project(
      idpro: project["idpro"] ?? 0,
      nom: project["nom"] ?? "",
      date:project["date"] ?? "",
      description: project["description"] ?? "",
      latitude: double.parse(project["latitude"]) ?? 0.0,
      longitude: double.parse(project["longitude"]) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "idpro": idpro,
      "nom": nom,
      "date":date,
      "description": description,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "hibernateLazyInitializer": {}
    };
  }
}

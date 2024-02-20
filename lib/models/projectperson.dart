
import 'package:interviewapp/models/person.dart';
import 'package:interviewapp/models/project.dart';

class ProjectPerson {
  Id id;
  Project projecto;
  Person persono;

  ProjectPerson({required this.id, required this.projecto, required this.persono});

  factory ProjectPerson.fromJson(Map<String, dynamic> json) {
    return ProjectPerson(
      id: Id.fromJson(json['id']),
      projecto: Project.fromJson(json['projecto']),
      persono: Person.fromJson(json['persono']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'projecto': projecto.toJson(),
      'persono': persono.toJson(),
    };
  }
}

class Id {
  int idpro;
  int idperson;

  Id({required this.idpro, required this.idperson});

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      idpro: json['idpro'],
      idperson: json['idperson'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'idpro': idpro,
      'idperson': idperson,
    };
  }
}
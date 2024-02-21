class Person {
  int? idperson;
  String? nom;
  String? prenom;
  String? mail;
  String? password;
  String? username;
  dynamic status;
  List<String>? roles;

  Person({
    this.idperson,
    this.nom,
    this.prenom,
    this.mail,
    this.password,
    this.username,
    this.status,
    this.roles,
  });

  factory Person.fromJson(Map<String, dynamic>? json) {
    return Person(
      idperson: json?['idperson'],
      nom: json?['nom'],
      prenom: json?['prenom'],
      mail: json?['mail'],
      password: json?['password'],
      username: json?['username'],
      status: json?['status'],
      roles: List<String>.from(json?['roles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idperson': idperson,
      'nom': nom ,
      'prenom': prenom,
      'mail': mail,
      'password': password,
      'username': username,
      'status': status,
      'roles': roles,
      'hibernateLazyInitializer': {}
    };
  }
}

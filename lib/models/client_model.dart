class ClientModel {
  final int? id;
  final String numCompte;
  final String nom;
  final String dateNaissance;
  final int service;
  final String mobile;
  final String langue;
  final int actif;
  final int? idAgence;
  final int userId;

  ClientModel(
      {required this.id,
      required this.numCompte,
      required this.nom,
      required this.dateNaissance,
      required this.service,
      required this.mobile,
      required this.langue,
      required this.actif,
      required this.idAgence,
      required this.userId});

  // data from json
  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: int.parse(json["id"]),
      numCompte: json["numCompte"],
      nom: json["nom"],
      dateNaissance: json["dateNaissance"],
      service: int.parse(json["service"]),
      mobile: json["mobile"],
      langue: json["langue"],
      idAgence: int.tryParse(json["idAgence"]) ?? 0,
      actif: int.parse(json["actif"]),
      userId: int.parse(json["userId"]));
}

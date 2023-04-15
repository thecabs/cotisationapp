class CotisationModel {
  final int? id;
  final int montant;
  final String date;
  final String heure;
  final int idClient;
  final int idUser;
  final String mobile;
  final String numCompte;
  final int idAgence;
  final String nom;

  CotisationModel(
      {this.id,
      required this.montant,
      required this.date,
      required this.heure,
      required this.idClient,
      required this.idUser,
      required this.mobile,
      required this.numCompte,
      required this.idAgence,
      required this.nom});

  // data from Json
  factory CotisationModel.fromJson(Map<String, dynamic> json) =>
      CotisationModel(
          id: int.parse(json["id"]),
          montant: int.parse(json["montant"]),
          date: json["date"],
          heure: json["heure"],
          idClient: int.parse(json["idClient"]),
          idUser: int.parse(json["idUser"]),
          mobile: json["mobile"],
          idAgence: int.tryParse(json["idAgence"]) ?? 0,
          numCompte: json["numCompte"],
          nom: json["nom"]);
}

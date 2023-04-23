class AddClientModel {
  final String mobile;
  final String username;
  final String daten;
  final String lieun;
  final String genre;
  final String lang;
  final String numcni;
  final String datecni;
  final String lieucni;
  final String profession;

  final int? idAgence;
  final int idUser;
  final int idZone;

  AddClientModel({
    required this.mobile,
    required this.username,
    required this.daten,
    required this.lieun,
    required this.genre,
    required this.lang,
    required this.numcni,
    required this.datecni,
    required this.lieucni,
    required this.profession,
    required this.idUser,
    required this.idAgence,
    required this.idZone,
  });

  // data from json
  factory AddClientModel.fromJson(Map<String, dynamic> json) => AddClientModel(
        mobile: json["mobile"],
        username: json["nom"],
        daten: json["dateNaissance"],
        lieun: json["lieuNaissance"],
        genre: json["sexe"],
        lang: json["langue"],
        numcni: json["cni"],
        datecni: json["dateDelivrance"],
        lieucni: json["lieuDelivrance"],
        profession: json["profession"],
        idUser: json["idUser"],
        idAgence: json["idAgence"],
        idZone: json["idZone"],
      );
}

class BankModel {
  final String id;
  final String libelle;
  final String adresse;
  final String email;
  final String nomRepresentant;
  final String username;
  final String password;
  final String mobile;
  final String lienLogo;

  BankModel(
      {required this.id,
      required this.libelle,
      required this.adresse,
      required this.email,
      required this.nomRepresentant,
      required this.username,
      required this.password,
      required this.lienLogo,
      required this.mobile});

  // from json
  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
      id: json["id"],
      libelle: json["libelle"],
      adresse: json["adresse"],
      email: json["email"],
      nomRepresentant: json["nomRepresentant"],
      username: json["username"],
      password: json["password"],
      lienLogo: json["lienLogo"],
      mobile: json["mobile"]);
}

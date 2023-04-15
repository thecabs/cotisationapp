import 'dart:async';
import 'dart:convert';

import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/client_model.dart';

class ClientService {

  Future<bool> saveCotisation(
      {required CotisationModel cotisationModel}) async {

    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
        scheme: Constants.scheme,
        host: instance.getString("server"),
        path: "/api/pages/cotisation.php");

    Object body = json.encode({
      "montant": cotisationModel.montant,
      "date": cotisationModel.date,
      "heure": cotisationModel.heure,
      "idClient": cotisationModel.idClient,
      "idUser": cotisationModel.idUser,
      "mobile": cotisationModel.mobile,
      "numCompte": cotisationModel.numCompte,
      "nom": cotisationModel.nom,
      "idAgence": cotisationModel.id
    });
    
    Response response = await post(uri, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  Future<bool> confirmation({required mobile, required montant}) async {

    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
        scheme: Constants.scheme,
        host: instance.getString("server"),
        path: "/api/pages/confirmation.php");

    Object body = json.encode({
      "mobile": mobile,
      "montant": montant
    });

    Response response = await post(uri, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }



  Future<ClientModel?> findClient(String numCompte,String code,String idAgence) async {

    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
        scheme: Constants.scheme,
        host: instance.getString("server"),
        path: "/api/pages/searchClient.php");

    Object body = json.encode({"numCompte": numCompte,"idZone":code,"idAgence":idAgence});
    Response response = await post(uri, body: body);

    final data =
        json.decode(const Utf8Decoder().convert(response.bodyBytes))["data"]
            as List;
    if (data.isNotEmpty) {
      return ClientModel.fromJson(data[0]);
    } else {
      return null;
    }
  }
}
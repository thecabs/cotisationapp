import 'dart:convert';

import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RechercheService {

  Future<List<CotisationModel>?> findCotisationSimple(
      {required String date1, required String date2, required String idUser}) async {

    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
        scheme: Constants.scheme,
        host: instance.getString("server"),
        path: "/api/pages/searchCotisationSimple.php");

    Object body = json.encode({"date1": date1, "date2": date2, "idUser": idUser});

    Response response = await post(uri, body: body);
    final data = json.decode(response.body)["data"] as List;

    return data.map((e) => CotisationModel.fromJson(e)).toList();
  }

  Future<List<CotisationModel>?> findCotisation(
      {required String date1,
      required String date2,
      required String numCompte, required String idUser}) async {

    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
        scheme: Constants.scheme,
        host: instance.getString("server"),
        path: "/api/pages/searchCotisation.php");

    Object body = 
      json.encode({"date1": date1, "date2": date2, "numCompte": numCompte, "idUser": idUser});

    Response response = await post(uri, body: body);
    final data = json.decode(response.body)["data"] as List;

    return data.map((e) => CotisationModel.fromJson(e)).toList();
  }
}

import 'dart:convert';

import 'package:gpt/models/addclient_model.dart';
//import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClientService {
  Future<bool> saveclient({required AddClientModel addClientModel}) async {
    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
        scheme: Constants.scheme,
        host: instance.getString("server"),
        path: "/api/pages/addClient.php");

    Object body = json.encode({
      "mobile": addClientModel.mobile,
      "nom": addClientModel.username,
      "dateNaissance": addClientModel.daten,
      "lieuNaissance": addClientModel.lieun,
      "sexe": addClientModel.genre,
      "langue": addClientModel.lang,
      "cni": addClientModel.numcni,
      "dateDelivrance": addClientModel.datecni,
      "lieuDelivrance": addClientModel.lieucni,
      "profession": addClientModel.profession,
      "idUser": addClientModel.idUser,
      "idAgence": addClientModel.idAgence,
      "idZone": addClientModel.idZone
    });

    Response response = await post(uri, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:convert';

import 'package:gpt/models/bank_model.dart';
import 'package:gpt/models/user_model.dart';
import 'package:gpt/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<UserModel?> authentication(
      {required String username, required String password}) async {
    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
      scheme: Constants.scheme,
      host: instance.getString("server"),
      path: "/api/pages/authentication.php",
    );

    Object body = json.encode({"username": username, "password": password});
    try {
      Response response = await post(uri, body: body);
      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body)["data"];
        return UserModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<int?> userCotisation({required int id}) async {
    var instance = await SharedPreferences.getInstance();

    final uri = Uri(
      scheme: Constants.scheme,
      host: instance.getString("server"),
      path: "/api/pages/userCotisation.php",
    );

    Object body = json.encode({"id": id});
    try {
      Response response = await post(uri, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body)["data"];

        return data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<BankModel?> findBank({required int id, required String server}) async {
    final uri = Uri(
      scheme: Constants.scheme,
      host: server,
      path: "/api/pages/searchBank.php",
    );

    Object body = json.encode({"id": id});

    try {
      Response response = await post(uri, body: body);
      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body)["data"] as List;
        if (data.isNotEmpty) {
          return BankModel.fromJson(data[0]);
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

void main() async {}

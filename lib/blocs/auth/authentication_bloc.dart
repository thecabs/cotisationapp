// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/models/user_model.dart';
import 'package:gpt/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserService userService = UserService();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationOnLoginEvent>((event, emit) async {
      var instance = await SharedPreferences.getInstance();

      emit(const AuthenticationOnLoginWait());
      await Future.delayed(const Duration(seconds: 2));

      UserModel? userModel = await userService.authentication(
          username: event.username, password: event.password);
      if (userModel != null) {
        instance.setBool("login", true);
        instance.setInt("id_user", userModel.id!);
        instance.setString("nom_user", userModel.nom!);
        instance.setString("username_user", userModel.username!);
        instance.setString("adresse_user", userModel.adresse!);
        instance.setInt("id_agence", userModel.idAgence!);
        instance.setInt("id_zone", userModel.idZone!);
        instance.setString("code_user", userModel.code!);

        emit(AuthenticationOnLoginSuccess(userModel: userModel));
      } else {
        emit(const AuthenticationOnLoginError());
      }
    });

    on<AuthenticationOnLoadNameBank>((event, emit) async {
      var instance = await SharedPreferences.getInstance();
      String? bankName = instance.getString("bank_name");

      emit(AuthenticationLoadName(bankName: bankName!));
    });
  }
}

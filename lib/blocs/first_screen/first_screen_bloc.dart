// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/models/bank_model.dart';
import 'package:gpt/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'first_screen_event.dart';
part 'first_screen_state.dart';

class FirstScreenBloc extends Bloc<FirstScreenEvent, FirstScreenState> {
  final UserService userService = UserService();

  FirstScreenBloc() : super(FirstScreenInitial()) {
    on<FirstScreenEvent>((event, emit) {});

    on<FirstScreenSubmitDataEvent>((event, emit) async {
      var instance = await SharedPreferences.getInstance();

      emit(const FirstScreenWaitingSubmitData());
      await Future.delayed(const Duration(seconds: 2));

      BankModel? bankModel = await userService.findBank(
          id: int.parse(event.banqueId), server: event.serverAdress);
      if (bankModel != null) {
        instance.setString("server", event.serverAdress);
        instance.setString("bank_name", bankModel.libelle);
        emit(FirstScreenSuccess(bankModel: bankModel));
      } else {
        emit(FirstScreenErrorState());
      }
    });

    on<FirstScreenCheckEvent>((event, emit) async {
      var instance = await SharedPreferences.getInstance();
      switch (instance.getBool("login")) {
        case false:
          emit(FirstScreenGoAuthenticationState());
          break;

        case true:
          int? id = instance.getInt("id_user");
          String? nom = instance.getString("nom_user");
          String? username = instance.getString("username_user");
          String? adresse = instance.getString("adresse_user");
          int? idAgence = instance.getInt("id_agence");
          int? idZone = instance.getInt("id_zone");
          String? code = instance.getString("code_user");
          
          print("===================================");
          print(idZone);
          print(idAgence);
          
          //int? idAgence = instance.getInt("id_agence");
          emit(FirstScreenGoMainScreenState(id: id!, nom: nom!, username: username!, adresse: adresse!,idAgence: idAgence!,idZone: idZone!,code: code!));
          break;
        default:
          // ignore: avoid_print
          print("Stay focus on first screen !");
          break;
      }
    });
  }
}

part of 'first_screen_bloc.dart';

abstract class FirstScreenState extends Equatable {
  const FirstScreenState();

  @override
  List<Object> get props => [];
}

class FirstScreenInitial extends FirstScreenState {}

class FirstScreenSubmitData extends FirstScreenState {
  const FirstScreenSubmitData();

  @override
  List<Object> get props => [];
}

class FirstScreenWaitingSubmitData extends FirstScreenState {
  const FirstScreenWaitingSubmitData();

  @override
  List<Object> get props => [];
}

class FirstScreenSuccess extends FirstScreenState {
  final BankModel bankModel;
  const FirstScreenSuccess({required this.bankModel});

  @override
  List<Object> get props => [bankModel];
}

class FirstScreenErrorState extends FirstScreenState {}

class FirstScreenGoAuthenticationState extends FirstScreenState {}

class FirstScreenGoMainScreenState extends FirstScreenState {
  final int id;
  final String nom;
  final String username;
  final String adresse;
  final int idAgence;
  //added
  final String code;
  final int idZone;
  

  const FirstScreenGoMainScreenState({required this.id, required this.nom, required this.adresse, required this.username,required this.idAgence,required this.idZone,required this.code});

  @override
  List<Object> get props => [id, nom, username, adresse,idAgence,idZone,code];  
}

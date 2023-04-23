part of 'client_bloc.dart';

abstract class AddClientState extends Equatable {
  const AddClientState();

  @override
  List<Object> get props => [];
}

class AddClientInitial extends AddClientState {}

class AddClientSelectFirstDateNState extends AddClientState {
  final DateTime date;
  const AddClientSelectFirstDateNState({required this.date});

  @override
  List<Object> get props => [date];
}

class AddClientSelectSecondDateNState extends AddClientState {
  final DateTime date;
  const AddClientSelectSecondDateNState({required this.date});

  @override
  List<Object> get props => [date];
}

class AddClientSelectFirstDateCNIState extends AddClientState {
  final DateTime date1;
  const AddClientSelectFirstDateCNIState({required this.date1});

  @override
  List<Object> get props => [date1];
}

class AddClientSelectSecondDateCNIState extends AddClientState {
  final DateTime date1;
  const AddClientSelectSecondDateCNIState({required this.date1});

  @override
  List<Object> get props => [date1];
}

class AddClientDataWaitingState extends AddClientState {
  const AddClientDataWaitingState();

  @override
  List<Object> get props => [];
}

class AddClientWaitingSave extends AddClientState {
  const AddClientWaitingSave();

  @override
  List<Object> get props => [];
}

class ClientSave extends AddClientState {
  const ClientSave();

  @override
  List<Object> get props => [];
}

class ClientErrorSave extends AddClientState {
  const ClientErrorSave();

  @override
  List<Object> get props => [];
}

class ClientErrorState extends AddClientState {
  const ClientErrorState();

  @override
  List<Object> get props => [];
}

class ClientSaveState extends AddClientState {
  final int id;
  final String nom;
  final String username;
  final String adresse;
  final int idAgence;
  //added
  final String code;
  final int idZone;

  const ClientSaveState(
      {required this.id,
      required this.nom,
      required this.adresse,
      required this.username,
      required this.idAgence,
      required this.idZone,
      required this.code});

  @override
  List<Object> get props =>
      [id, nom, username, adresse, idAgence, idZone, code];
}

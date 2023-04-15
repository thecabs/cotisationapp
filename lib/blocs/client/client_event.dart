part of 'client_bloc.dart';

abstract class AddClientEvent extends Equatable {
  const AddClientEvent();

  @override
  List<Object> get props => [];
}

class AddClientInitialEvent extends AddClientEvent {}

class AddClientSelectFirstDateNEvent extends AddClientEvent {
  final DateTime date;
  const AddClientSelectFirstDateNEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class AddClientSelectSecondDateNEvent extends AddClientEvent {
  final DateTime date;
  const AddClientSelectSecondDateNEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class AddClientSelectFirstDateCNIEvent extends AddClientEvent {
  final DateTime date1;
  const AddClientSelectFirstDateCNIEvent({required this.date1});

  @override
  List<Object> get props => [date1];
}

class AddClientSelectSecondDateCNIEvent extends AddClientEvent {
  final DateTime date1;
  const AddClientSelectSecondDateCNIEvent({required this.date1});

  @override
  List<Object> get props => [date1];
}

class AddClientDataEvent extends AddClientEvent {
  final String date1;
  final String date2;
  final String numCompte;
  final String idUser;

  const AddClientDataEvent(
      {required this.date1,
      required this.date2,
      required this.numCompte,
      required this.idUser});

  @override
  List<Object> get props => [date1, date2, numCompte, idUser];
}

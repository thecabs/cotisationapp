part of 'recherche_bloc.dart';

abstract class RechercheEvent extends Equatable {
  const RechercheEvent();

  @override
  List<Object> get props => [];
}

class RechercheInitialEvent extends RechercheEvent {}

class RechercheSelectFirstDateEvent extends RechercheEvent {
  final DateTime date;
  const RechercheSelectFirstDateEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class RechercheSelectSecondDateEvent extends RechercheEvent {
  final DateTime date;
  const RechercheSelectSecondDateEvent({required this.date});

  @override
  List<Object> get props => [date];
}

class RecherchePrecisionEvent extends RechercheEvent {
  final String date1;
  final String date2;
  final String numCompte;
  final String idUser;

  const RecherchePrecisionEvent(
      {required this.date1, required this.date2, required this.numCompte, required this.idUser});

  @override
  List<Object> get props => [date1, date2, numCompte, idUser];
}

class RechercheSansPrecisionEvent extends RechercheEvent {
  final String date1;
  final String date2;
  final String idUser;

  const RechercheSansPrecisionEvent({required this.date1, required this.date2, required this.idUser});

  @override
  List<Object> get props => [date1, date2];
}


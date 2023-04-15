part of 'recherche_bloc.dart';

abstract class RechercheState extends Equatable {
  const RechercheState();

  @override
  List<Object> get props => [];
}

class RechercheInitial extends RechercheState {}

class RechercheSelectFirstDateState extends RechercheState {
  final DateTime date;
  const RechercheSelectFirstDateState({required this.date});

  @override
  List<Object> get props => [date];
}

class RechercheSelectSecondDateState extends RechercheState {
  final DateTime date;
  const RechercheSelectSecondDateState({required this.date});

  @override
  List<Object> get props => [date];
}

//// recherche precision waiting state
class RecherchePrecisionWaitingState extends RechercheState {
  const RecherchePrecisionWaitingState();

  @override
  List<Object> get props => [];
}

//// recherche precision state
class RechercheSuccessState extends RechercheState {
  final List<CotisationModel> cotisationModel;
  const RechercheSuccessState({required this.cotisationModel});

  @override
  List<Object> get props => [cotisationModel];
}

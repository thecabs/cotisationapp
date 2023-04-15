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

//// recherche precision waiting state
class AddClientDataWaitingState extends AddClientState {
  const AddClientDataWaitingState();

  @override
  List<Object> get props => [];
}

//// recherche precision state
class AddClientDataSuccessState extends AddClientState {
  final List<CotisationModel> cotisationModel;
  const AddClientDataSuccessState({required this.cotisationModel});

  @override
  List<Object> get props => [cotisationModel];
}

class AddClientWaitingSubmitData extends AddClientState {
  const AddClientWaitingSubmitData();

  @override
  List<Object> get props => [];
}

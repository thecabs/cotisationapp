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
  final AddClientModel addclientModel;
  const AddClientDataEvent({required this.addclientModel});

  @override
  List<Object> get props => [addclientModel];
}

class AddClientStep1Event extends AddClientEvent {
  const AddClientStep1Event();

  @override
  List<Object> get props => [];
}

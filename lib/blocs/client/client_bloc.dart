// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/services/addclient_service.dart';

part 'client_event.dart';
part 'client_state.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final AddClientService addclientService = AddClientService();

  AddClientBloc() : super(AddClientInitial()) {
    on<AddClientSelectFirstDateNEvent>((event, emit) {
      emit(AddClientSelectFirstDateNState(date: event.date));
    });

    on<AddClientSelectSecondDateNEvent>((event, emit) {
      emit(AddClientSelectSecondDateNState(date: event.date));
    });
    on<AddClientSelectFirstDateCNIEvent>((event1, emit1) {
      emit1(AddClientSelectFirstDateCNIState(date1: event1.date1));
    });

    on<AddClientSelectSecondDateCNIEvent>((event1, emit1) {
      emit1(AddClientSelectSecondDateCNIState(date1: event1.date1));
    });

    on<AddClientInitialEvent>((event, emit) {
      emit(AddClientInitial());
    });
  }
}

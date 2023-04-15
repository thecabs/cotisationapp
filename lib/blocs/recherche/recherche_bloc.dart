// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/services/recherche_service.dart';

part 'recherche_event.dart';
part 'recherche_state.dart';

class RechercheBloc extends Bloc<RechercheEvent, RechercheState> {
  final RechercheService rechercheService = RechercheService();

  RechercheBloc() : super(RechercheInitial()) {
    on<RechercheSelectFirstDateEvent>((event, emit) {
      emit(RechercheSelectFirstDateState(date: event.date));
    });

    on<RechercheSelectSecondDateEvent>((event, emit) {
      emit(RechercheSelectSecondDateState(date: event.date));
    });

    on<RechercheInitialEvent>((event, emit) {
      emit(RechercheInitial());
    });

    on<RecherchePrecisionEvent>((event, emit) async {
      emit(const RecherchePrecisionWaitingState());
      final List<CotisationModel>? cotisationModel =
          await rechercheService.findCotisation(
              date1: event.date1,
              date2: event.date2,
              idUser: event.idUser,
              numCompte: event.numCompte);

      if (cotisationModel != null) {
        emit(RechercheSuccessState(cotisationModel: cotisationModel));
        return;
      }
    });

    on<RechercheSansPrecisionEvent>((event, emit) async {
      emit(const RecherchePrecisionWaitingState());
      final cotisationModel = await rechercheService.findCotisationSimple(
          date1: event.date1, date2: event.date2, idUser: event.idUser);

      if (cotisationModel != null) {
        emit(RechercheSuccessState(cotisationModel: cotisationModel));
        return;
      }
    });
  }
}

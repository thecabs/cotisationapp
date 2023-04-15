// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/models/client_model.dart';
import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/services/client_service.dart';

part 'cotisation_event.dart';

part 'cotisation_state.dart';

class CotisationBloc extends Bloc<CotisationEvent, CotisationState> {
  final ClientService clientService = ClientService();

  CotisationBloc() : super(CotisationInitial()) {
    on<CotisationOnSearchEvent>((event, emit) async {
      emit(const CotisationWaitingSearchState());
      final ClientModel? clientModel =
          await clientService.findClient(event.numCompte,event.code,event.idAgence);

      if (clientModel != null) {
        emit(CotisationSearchState(clientModel: clientModel));
        return;
      } else {
        emit(const CotisationSearchErrorState());
        return;
      }
    });

    on<CotisationOnSaveEvent>((event, emit) async {
      emit(const CotisationWaitingSave());
      bool response = await clientService.saveCotisation(
          cotisationModel: event.cotisationModel);

      if (response) {

        bool responseConf = await clientService.confirmation(
            mobile: event.cotisationModel.mobile,
            montant: event.cotisationModel.montant);

        if (responseConf) {
          emit(const CotisationSave());
        }

      } else {
        emit(const CotisationSearchErrorState());
      }
    });
  }
}

part of 'cotisation_bloc.dart';

abstract class CotisationEvent extends Equatable {
  const CotisationEvent();

  @override
  List<Object> get props => [];
}

class CotisationOnSearchEvent extends CotisationEvent {
  final String numCompte;
  final String code;
  final String idAgence;
  
  
  const CotisationOnSearchEvent({required this.numCompte,required this.code,required this.idAgence,});

  @override
  List<Object> get props => [numCompte,code,idAgence];
}

class CotisationOnSaveEvent extends CotisationEvent {
  final CotisationModel cotisationModel;
  const CotisationOnSaveEvent({required this.cotisationModel});

  @override
  List<Object> get props => [cotisationModel];
}

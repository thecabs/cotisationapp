part of 'cotisation_bloc.dart';

abstract class CotisationState extends Equatable {
  const CotisationState();

  @override
  List<Object> get props => [];
}

class CotisationInitial extends CotisationState {}

class CotisationWaitingSearchState extends CotisationState {
  const CotisationWaitingSearchState();

  @override
  List<Object> get props => [];
}

class CotisationSearchState extends CotisationState {
  final ClientModel clientModel;
  const CotisationSearchState({required this.clientModel});

  @override
  List<Object> get props => [];
}

class CotisationSearchErrorState extends CotisationState {
  const CotisationSearchErrorState();

  @override
  List<Object> get props => [];
}

class CotisationWaitingSave extends CotisationState {
  const CotisationWaitingSave();

  @override
  List<Object> get props => [];
}

class CotisationSave extends CotisationState {
  const CotisationSave();

  @override
  List<Object> get props => [];
}

class CotisationErrorSave extends CotisationState {
  const CotisationErrorSave();

  @override
  List<Object> get props => [];
}

part of 'first_screen_bloc.dart';

abstract class FirstScreenEvent extends Equatable {
  const FirstScreenEvent();

  @override
  List<Object> get props => [];
}

class FirstScreenSubmitDataEvent extends FirstScreenEvent {

  final String serverAdress;
  final String banqueId;
  const FirstScreenSubmitDataEvent({required this.serverAdress, required this.banqueId});

  @override
  List<Object> get props => [serverAdress, banqueId];

}

class FirstScreenCheckEvent extends FirstScreenEvent {
  const FirstScreenCheckEvent();

  @override
  List<Object> get props => [];
}
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoadName extends AuthenticationState {
  final String bankName;
  AuthenticationLoadName({required this.bankName});

  @override
  List<Object> get props => [bankName];
}

class AuthenticationOnLoginSuccess extends AuthenticationState {

  final UserModel userModel;
  const AuthenticationOnLoginSuccess({required this.userModel});
  
  @override
  List<Object> get props => [userModel];

}

class AuthenticationOnLoginError extends AuthenticationState {

  const AuthenticationOnLoginError();
  
  @override
  List<Object> get props => [];

}

class AuthenticationOnLoginWait extends AuthenticationState {

  const AuthenticationOnLoginWait();

  @override
  List<Object> get props => [];
}
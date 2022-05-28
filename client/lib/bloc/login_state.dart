abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;
  LoginErrorState({required this.errorMessage});
}

class LoginValidState extends LoginState {}

class LoginLoadingState extends LoginState {}

abstract class LoginEvent {}

class LoginTextFieldChangeEvent extends LoginEvent {
  final String userIdValue, passwordValue;
  LoginTextFieldChangeEvent(
      {required this.userIdValue, required this.passwordValue});
}

class OnButtonSubmitEvent extends LoginEvent {
  final String userId, password;
  OnButtonSubmitEvent({required this.userId, required this.password});
}

import 'package:bloc/bloc.dart';
import 'package:gmap/bloc/login_event.dart';
import 'package:gmap/bloc/login_state.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginTextFieldChangeEvent>((event, emit) {
      if (event.userIdValue.length < 8) {
        emit(LoginErrorState(errorMessage: 'Please Enter a valid Userid'));
      } else if (event.passwordValue.length < 4) {
        emit(LoginErrorState(errorMessage: 'Please Enter a Valid Password'));
      } else {
        emit(LoginValidState());
      }
    });
    on<OnButtonSubmitEvent>((event, emit) {
      emit(LoginLoadingState());
    });
  }
}

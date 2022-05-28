import 'package:bloc/bloc.dart';
import 'package:gmap/bloc/welcome_event.dart';
import 'package:gmap/bloc/welcome_state.dart';
import 'package:meta/meta.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<WelcomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/app/auth/servise/auth_service.dart';
import 'package:flutter_application_1/di/di.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServiceInterface authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<AuthRegister>(_onRegister);
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  Future<void> _onRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authService.signUp(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } catch (e, st) {
      talker.handle(e, st);
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authService.logIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } catch (e, st) {
      talker.handle(e, st);
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authService.logOut();
      emit(AuthInitial());
    } catch (e, st) {
      talker.handle(e, st);
      emit(AuthFailure(e.toString()));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
  })  : _signIn = signIn,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInEvent>(_signInHandler);
  }

  final SignIn _signIn;

  /// Handler for sign-in logic.
  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(username: event.username, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (userLoginResponse) => emit(SignedIn(userLoginResponse)),
    );
  }
}

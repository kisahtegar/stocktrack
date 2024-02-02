import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// This bloc responsible for handling authentication events and state
/// transitions.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Constructor for creating an instance of [AuthBloc].
  ///
  /// Requires a [SignIn] use case to handle the sign-in functionality.
  AuthBloc({
    required SignIn signIn,
  })  : _signIn = signIn,
        super(const AuthInitial()) {
    // Trigger AuthLoading state on any AuthEvent
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });

    // Trigger _signInHandler on SignInEvent
    on<SignInEvent>(_signInHandler);
  }

  /// Instance of the [SignIn] use case for performing sign-in operations.
  final SignIn _signIn;

  /// Handler for sign-in logic.
  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Call the sign-in use case with the provided credentials
    final result = await _signIn(
      UserLoginRequest(
        username: event.username,
        password: event.password,
      ),
    );

    // Handle the result and emit corresponding AuthState
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (userLoginResponse) => emit(SignedIn(userLoginResponse)),
    );
  }
}

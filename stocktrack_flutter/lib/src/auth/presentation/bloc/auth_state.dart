part of 'auth_bloc.dart';

/// These state classes provide a structured way to represent and manage the
/// different states of the authentication process within the `AuthBloc`. Each
/// state encapsulates the necessary data and information about the current
/// state of authentication, making it easier to handle and respond to different
/// scenarios and transitions in the user authentication flow.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the authentication process.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Represents the state when authentication actions are in progress.
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Represents the state when a user has successfully signed in.
final class SignedIn extends AuthState {
  const SignedIn(this.userLoginResponse);

  final UserLoginResponse userLoginResponse;

  @override
  List<Object> get props => [userLoginResponse];
}

/// Represents the state when an error occurs during authentication.
final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

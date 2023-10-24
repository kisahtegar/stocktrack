part of 'auth_bloc.dart';

/// These event classes provide a structured way to represent different user
/// actions and events related to authentication in the application. They
/// encapsulate the necessary data for each event and ensure type safety during
/// event creation. These events will likely be used to trigger state changes
/// and perform corresponding authentication logic within the `AuthBloc`.
sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

/// Represents an event for user sign-in.
final class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<String> get props => [username, password];
}

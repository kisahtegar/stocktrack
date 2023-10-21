import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stocktrack_flutter/src/auth/domain/entities/user.dart';
import 'package:stocktrack_flutter/src/auth/domain/usecases/sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required SignIn signIn})
      : _signIn = signIn,
        super(const AuthInitial());

  final SignIn _signIn;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    // emit();
    final result = await _signIn(
      SignInParams(username: username, password: password),
    );
    debugPrint('AuthCubit(signIn): result = $result');
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (userLoginResponse) => emit(SignedIn(userLoginResponse)),
    );
  }

  void tokenExpired() {
    emit(const NotLoggedIn());
  }
}

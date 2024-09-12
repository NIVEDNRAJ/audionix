// presentation/bloc/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/auth/logout.dart';

class AuthCubit extends Cubit<AuthState> {
  final LogoutUseCase logoutUseCase;

  AuthCubit(this.logoutUseCase) : super(AuthInitial());

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase.call();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError("Logout failed: ${e.toString()}"));
    }
  }
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthLoggedOut extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

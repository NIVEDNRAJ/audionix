// presentation/bloc/auth_state.dart

// The abstract base class for all authentication states
abstract class AuthState {}

// Initial state, e.g., when the app starts or is waiting for an action
class AuthInitial extends AuthState {}

// State when the system is performing some authentication-related action (like logging out)
class AuthLoading extends AuthState {}

// State when the user has successfully logged out
class AuthLoggedOut extends AuthState {}

// Error state for handling failures, such as logout failure
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthIsUserLoggedInEvent extends AuthEvent {}

final class AuthSignInWithPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInWithPasswordEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class AuthSignOutEvent extends AuthEvent {}

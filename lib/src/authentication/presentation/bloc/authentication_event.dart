part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<dynamic> get props => [];
}

class SignInEvent extends AuthenticationEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthenticationEvent {
  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object> get props => [name, email, password];
}

class ForgotPasswordEvent extends AuthenticationEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class UpdateUserEvent extends AuthenticationEvent {
  const UpdateUserEvent({
    required this.action,
    required this.userData,
  });

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}

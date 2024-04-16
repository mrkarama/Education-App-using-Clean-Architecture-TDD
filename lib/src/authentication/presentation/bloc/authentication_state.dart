part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class UserSignedIn extends AuthenticationState {
  const UserSignedIn(this.user);

  final LocaleUser user;

  @override
  List<LocaleUser> get props => [user];
}

class UserSignedUp extends AuthenticationState {
  const UserSignedUp();
}

class UserDataUpdated extends AuthenticationState {
  const UserDataUpdated();
}

class UserPasswordSent extends AuthenticationState {
  const UserPasswordSent();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

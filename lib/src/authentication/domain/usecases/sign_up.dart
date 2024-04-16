import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  const SignUp(this._repository);

  final AuthenticationRepository _repository;
  @override
  ResultFuture<void> call(SignUpParams params) => _repository.signUp(
        name: params.name,
        email: params.email,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          name: '',
          password: '',
        );

  final String name;
  final String email;
  final String password;
  @override
  List<Object?> get props => [name, email, password];
}

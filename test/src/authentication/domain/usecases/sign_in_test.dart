import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late SignIn usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = SignIn(repository);
  });

  test(
      'should call [AuthenticationRepository.signIn] and return the right '
      'data(LocalUser)', () async {
    const tSignInParams = SignInParams.empty();
    const tUser = LocaleUser.empty();

    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Right(
        tUser,
      ),
    );

    final result = await usecase(tSignInParams);

    expect(result, equals(const Right<dynamic, LocaleUser>(tUser)));

    verify(
      () => repository.signIn(
        email: tSignInParams.email,
        password: tSignInParams.password,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

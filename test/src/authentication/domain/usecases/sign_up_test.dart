import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late SignUp usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = SignUp(repository);
  });

  test(
      'should called [AuthenticationRepository.signUp] and return the right '
      'data(void)', () async {
    const tSignUpParams = SignUpParams.empty();
    when(
      () => repository.signUp(
        name: any(named: 'name'),
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase(tSignUpParams);

    expect(result, const Right<dynamic, void>(null));

    verify(
      () => repository.signUp(
        name: tSignUpParams.name,
        email: tSignUpParams.email,
        password: tSignUpParams.password,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

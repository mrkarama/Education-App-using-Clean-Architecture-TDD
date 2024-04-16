import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = ForgotPassword(repository);
  });

  test(
      'should call [AuthenticationRepository.forgotPassword] and return the '
      'right(void)', () async {
    const tEmail = '';
    when(() => repository.forgotPassword(any())).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase(tEmail);
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(() => repository.forgotPassword(tEmail)).called(1);
    verifyNoMoreInteractions(repository);
  });
}

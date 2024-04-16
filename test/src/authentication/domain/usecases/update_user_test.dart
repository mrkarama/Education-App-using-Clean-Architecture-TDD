import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late UpdateUser usecase;

  const tUpdateUserAction = UpdateUserAction.displayName;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = UpdateUser(repository);
    registerFallbackValue(tUpdateUserAction);
  });

  test(
      'should call [AuthenticationRepository.forgotPassword] and return the '
      'right data(void)', () async {
    const tUpdateUserParams = UpdateUserParams.empty();
    when(
      () => repository.updateUser(
        action: any(named: 'action'),
        // ignore: inference_failure_on_function_invocation
        userData: any(named: 'userData'),
      ),
    ).thenAnswer(
      (_) async => const Right(
        null,
      ),
    );
    final result = await usecase(tUpdateUserParams);
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.updateUser(
        action: tUpdateUserParams.action,
        userData: tUpdateUserParams.userData,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

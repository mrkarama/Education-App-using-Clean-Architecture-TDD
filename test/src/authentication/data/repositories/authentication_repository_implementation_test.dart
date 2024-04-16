import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;

  const tAction = UpdateUserAction.displayName;

  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImplementation =
        AuthenticationRepositoryImplementation(remoteDataSource);
    registerFallbackValue(tAction);
  });

  const tName = 'Bob';
  const tEmail = 'bob@gmail';
  const tPassword = '123456';

  final tServerException = ServerFailure(
    // Variable name should be tServerFailure
    message: 'Unknown error occurred',
    statusCode: 'unknown-error',
  );

  test('should be a subclass of [AuthenticationRepository]', () {
    expect(repositoryImplementation, isA<AuthenticationRepository>());
  });

  group('signIn', () {
    test(
        'should call [remoteDataSource.signIn] and completes successfully '
        'when the call to the data source is successful', () async {
      const tLocalUser = LocalUserModel.empty();
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => tLocalUser,
      );

      final result = await repositoryImplementation.signIn(
        email: tEmail,
        password: tPassword,
      );
      expect(result, equals(const Right<dynamic, LocalUserModel>(tLocalUser)));
      verify(
        () => remoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should throw [ServerFailure] when exception occurs ', () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tServerException);

      final call = repositoryImplementation.signIn;
      expect(
        call(
          email: tEmail,
          password: tPassword,
        ),
        throwsA(isA<ServerFailure>()),
      );
      verify(
        () => remoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signUp', () {
    test(
        'should call [remoteDataSource.signUp] and completes successfully '
        'when the call to the data source is successful', () async {
      when(
        () => remoteDataSource.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      final call = repositoryImplementation.signUp;
      expect(
        call(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
        completes,
      );

      verify(
        () => remoteDataSource.signUp(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should throw [ServerFailure] when exception occurs', () async {
      when(
        () => remoteDataSource.signUp(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(
            named: 'password',
          ),
        ),
      ).thenThrow(tServerException);

      final call = repositoryImplementation.signUp;
      expect(
        call(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
        throwsA(isA<ServerFailure>()),
      );

      verify(
        () => remoteDataSource.signUp(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('forgotPassword', () {
    test(
        'should call [remoteDataSource.forgotPassword] and completes '
        'successfully when the call to the data source is successful',
        () async {
      when(() => remoteDataSource.forgotPassword(any())).thenAnswer(
        (_) async => Future.value(),
      );
      final call = repositoryImplementation.forgotPassword;

      expect(
        call(tEmail),
        completes,
      );
      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should throw [ServerFailure] when exception occurs', () async {
      when(() => remoteDataSource.forgotPassword(any())).thenThrow(
        tServerException,
      );
      final call = repositoryImplementation.forgotPassword;

      expect(
        () async => call(tEmail),
        throwsA(isA<ServerFailure>()),
      );
      verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('updateUser', () {
    test(
        'should call [remoteDataSource.updateUser] and completes '
        'successfully when the call to the data source is successful',
        () async {
      const tUserData = '';
      when(
        () => remoteDataSource.updateUser(
          action: any(named: 'action'),
          // ignore: inference_failure_on_function_invocation
          userData: any(named: 'userData'),
        ),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      final call = repositoryImplementation.updateUser;
      expect(
        call(
          action: tAction,
          userData: tUserData,
        ),
        completes,
      );
      verify(
        () => remoteDataSource.updateUser(
          action: tAction,
          userData: tUserData,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should throw [ServerFailure] when exception occurs ', () async {
      const tUserData = '';
      const tAction = UpdateUserAction.displayName;
      when(
        () => remoteDataSource.updateUser(
          action: any(named: 'action'),
          // ignore: inference_failure_on_function_invocation
          userData: any(named: 'userData'),
        ),
      ).thenThrow(tServerException);

      final call = repositoryImplementation.updateUser;
      expect(
        () async => call(
          action: tAction,
          userData: tUserData,
        ),
        throwsA(isA<ServerFailure>()),
      );
      verify(
        () => remoteDataSource.updateUser(
          action: tAction,
          userData: tUserData,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}

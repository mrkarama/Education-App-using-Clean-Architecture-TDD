import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_up.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user.dart';
import 'package:education_app/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthenticationBloc bloc;

  final tServerFailure = ServerFailure(
    message: 'Unknow error occurred',
    statusCode: '505',
  );
  const tSignInParams = SignInParams.empty();
  const tSignUpParams = SignUpParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();
  const tEmail = 'email@gmail.com';
  const tUser = LocalUserModel.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    bloc = AuthenticationBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );

    registerFallbackValue(tSignInParams);
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tUpdateUserParams);
  });

  tearDown(() => bloc.close());

  test('initial state should be [AuthenticationInitial]', () {
    expect(bloc.state, isA<AuthenticationInitial>());
  });

  group('signIn', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, UserSignedIn] when [SigninEvent] '
      'is added',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => const [
        AuthenticationLoading(),
        UserSignedIn(tUser),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, AuthenticationError] when '
      '[SigninEvent] fails to be added',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('signUp', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, UserSignedUp] when [SignUpEvent] '
      'is added',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          name: tSignUpParams.name,
          email: tSignUpParams.email,
          password: tSignUpParams.password,
        ),
      ),
      expect: () => const [
        AuthenticationLoading(),
        UserSignedUp(),
      ],
      verify: (_) {
        verify(() => signUp(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, AuthenticationError] when '
      '[SignUpEvent] fails to be added',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          name: tSignUpParams.name,
          email: tSignUpParams.email,
          password: tSignUpParams.password,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => signUp(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('ForgotPassword', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, UserPasswordSent] when '
      '[ForgotPasswordEvent] is added',
      build: () {
        when(() => forgotPassword(any())).thenAnswer(
          (_) async => const Right(
            null,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(
          tEmail,
        ),
      ),
      expect: () => const [
        AuthenticationLoading(),
        UserPasswordSent(),
      ],
      verify: (_) {
        verify(() => forgotPassword(tEmail)).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, AuthenticationError] when '
      '[ForgotPassword] fails to be added',
      build: () {
        when(() => forgotPassword(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(
          tEmail,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => forgotPassword(tEmail)).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });

  group('UpdateUser', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, UserDataUpdated] when '
      '[UpdateUserEvent] is added',
      build: () {
        when(() => updateUser(any())).thenAnswer(
          (_) async => const Right(
            null,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          userData: tUpdateUserParams.userData,
        ),
      ),
      expect: () => const [
        AuthenticationLoading(),
        UserDataUpdated(),
      ],
      verify: (_) {
        verify(() => updateUser(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'should emit [AuthenticationLoading, AuthenticationError] when '
      '[UpdateUserEvent] fails to be added',
      build: () {
        when(() => updateUser(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          userData: tUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => updateUser(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });
}

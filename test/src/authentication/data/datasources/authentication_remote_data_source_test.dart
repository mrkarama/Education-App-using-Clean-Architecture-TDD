import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  User? _user;

  @override
  User? get currentUser => _user;

  set currentUser(User? user) {
    if (_user != user) _user = user;
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}

class MockUser extends Mock implements User {
  String _uid = 'Fake uid';

  @override
  String get uid => _uid;

  set uid(String uid) {
    if (_uid != uid) _uid = uid;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential(User? user) : _user = user;

  User? _user;

  @override
  User? get user => _user;

  set user(User? user) {
    if (_user != user) _user = user;
  }
}

void main() {
  late FirebaseAuth authClient;
  late MockFirebaseStorage dbClient;
  late FakeFirebaseFirestore cloudStoreClient;
  late AuthenticationRemoteDataSourceImplementation
      remoteDataSourceImplementation;

  late User mockUser;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;

  const tUser = LocalUserModel.empty();
  const tName = 'Bob';
  const tEmail = 'bob@gmail.com';
  const tPassword = '123@bob';
  const tNewPassword = '123456';
  const tDefaultAvatar = MediaRes.user;
  final tServerException = ServerException(
    message: 'User record does not exist',
    statusCode: 'user-may-have-been-deleted',
  );

  setUp(() {
    cloudStoreClient = FakeFirebaseFirestore();
    dbClient = MockFirebaseStorage();
    documentReference = cloudStoreClient.collection('users').doc();
    documentReference.set(
      tUser
          .copyWith(
            uid: documentReference.id,
            profilePic: kDefaultAvatar,
          )
          .toMap(),
    );

    mockUser = MockUser()..uid = documentReference.id;

    userCredential = MockUserCredential(mockUser);
    authClient = MockFirebaseAuth()..currentUser = mockUser;
    remoteDataSourceImplementation =
        AuthenticationRemoteDataSourceImplementation(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
    registerFallbackValue(MockAuthCredential());
  });

  test('should be a subclass of [AuthenticationRemoteDataSource]', () {
    expect(
      remoteDataSourceImplementation,
      isA<AuthenticationRemoteDataSource>(),
    );
  });

  group('signIn', () {
    test(
        'should call [remoteDataSourceImplemention.signIn] and completes '
        'successfully when no [FirebaseAuthException] occurs', () async {
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => userCredential,
      );

      final result = await remoteDataSourceImplementation.signIn(
        email: tEmail,
        password: tPassword,
      );
      final user =
          await cloudStoreClient.collection('users').doc(result.uid).get();

      expect(result.uid, userCredential.user!.uid);
      expect(user.data()!['email'], 'bob@gmail.com');
      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test('should throw [ServerException] when [FirebaseAuthException] occurs',
        () async {
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        tServerException,
      );

      final call = remoteDataSourceImplementation.signIn;

      expect(
        () async => call(
          email: tEmail,
          password: tPassword,
        ),
        throwsA(
          isA<ServerException>(),
        ),
      );
      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('signUp', () {
    test(
        'should call [remoteDataSourceImplementation.signUp] and completes '
        'successfull(void) when there is no [FirebaseAuthException]', () async {
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => userCredential,
      );

      when(() => authClient.currentUser!.updateDisplayName(any()))
          .thenAnswer((_) async => Future.value());
      when(() => authClient.currentUser!.updatePhotoURL(any()))
          .thenAnswer((_) async => Future.value());

      final call = remoteDataSourceImplementation.signUp;

      expect(
        call(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
        completes,
      );

      await untilCalled(() => authClient.currentUser!.updateDisplayName(any()));
      await untilCalled(() => authClient.currentUser!.updatePhotoURL(any()));
      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();
      expect(user.data()!['email'], equals('bob@gmail.com'));
      verify(() => authClient.currentUser!.updateDisplayName(tName));
      verify(() => authClient.currentUser!.updatePhotoURL(tDefaultAvatar));
      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
        'should throw [ServerException] when there is a '
        '[FirebaseAuthException]', () async {
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        tServerException,
      );

      final call = remoteDataSourceImplementation.signUp;

      expect(
        () async => call(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
        throwsA(
          isA<ServerException>(),
        ),
      );

      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('forgotPassword', () {
    test(
        'should call [remoteDataSourceImplementation.forgotPasword] and '
        'completes successfull(void) when there is no [FirebaseAuthException]',
        () async {
      when(
        () => authClient.sendPasswordResetEmail(
          email: any(named: 'email'),
        ),
      ).thenAnswer(
        (_) async => Future.value(),
      );

      final call = remoteDataSourceImplementation.forgotPassword;
      expect(call(tEmail), completes);

      verify(() => authClient.sendPasswordResetEmail(email: tEmail)).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test('should throw [ServerException] when [FirebaseAuthException] occurs',
        () async {
      when(
        () => authClient.sendPasswordResetEmail(
          email: any(named: 'email'),
        ),
      ).thenThrow(
        tServerException,
      );
      final call = remoteDataSourceImplementation.forgotPassword;
      expect(
        () async => call(tEmail),
        throwsA(
          isA<ServerException>(),
        ),
      );

      verify(() => authClient.sendPasswordResetEmail(email: tEmail)).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('updateUser', () {
    test(
        'should call [remoteDatSourceImplementation.updateuser] and '
        "updates the user's name successfully(void) when no "
        '[FirebaseException] occurs', () async {
      when(() => authClient.currentUser!.updateDisplayName(any())).thenAnswer(
        (_) async => Future.value(),
      );

      final call = remoteDataSourceImplementation.updateUser;
      expect(
        call(
          action: UpdateUserAction.displayName,
          userData: 'Pourou',
        ),
        completes,
      );

      await untilCalled(() => authClient.currentUser!.updateDisplayName(any()));

      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();
      expect(user.data()!['fullName'], 'Pourou');

      verify(() => authClient.currentUser!.updateDisplayName('Pourou'))
          .called(1);
      verifyNever(() => authClient.currentUser!.updatePassword(any()));
      verifyNever(() => authClient.currentUser!.verifyBeforeUpdateEmail(any()));
      verifyNever(() => authClient.currentUser!.updatePhotoURL(any()));
      verifyNoMoreInteractions(authClient);
    });

    test(
        'should call [remoteDatSourceImplementation.updateuser] and '
        "updates the user's email successfully(void) when no "
        '[FirebaseException] occurs', () async {
      when(() => authClient.currentUser!.verifyBeforeUpdateEmail(any()))
          .thenAnswer(
        (_) async => Future.value(),
      );

      final call = remoteDataSourceImplementation.updateUser;

      expect(
        call(
          action: UpdateUserAction.email,
          userData: 'new@gmail.com',
        ),
        completes,
      );
      await untilCalled(
        () => authClient.currentUser!.verifyBeforeUpdateEmail(
          any(),
        ),
      );
      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();
      expect(user.data()!['email'], 'new@gmail.com');

      verify(
        () => authClient.currentUser!.verifyBeforeUpdateEmail(
          'new@gmail.com',
        ),
      ).called(1);
      verifyNever(() => authClient.currentUser!.updatePassword(any()));
      verifyNever(() => authClient.currentUser!.updateDisplayName(any()));
      verifyNever(() => authClient.currentUser!.updatePhotoURL(any()));
      verifyNoMoreInteractions(authClient);
    });

    test(
        'should call [remoteDatSourceImplementation.updateuser] and '
        "updates the user's profilePic successfully(void) when no "
        '[FirebaseException] occurs', () async {
      final tProfilePic = File(MediaRes.user);
      when(() => authClient.currentUser!.updatePhotoURL(any())).thenAnswer(
        (_) async => Future.value(),
      );

      final call = remoteDataSourceImplementation.updateUser;

      expect(
        call(
          action: UpdateUserAction.profilePic,
          userData: tProfilePic,
        ),
        completes,
      );
      await untilCalled(
        () => authClient.currentUser!.updatePhotoURL(
          any(),
        ),
      );
      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();
      expect(user.data()!['profilePic'], MediaRes.user);
      expect(dbClient.storedFilesMap.isNotEmpty, isTrue);

      verify(
        () => authClient.currentUser!.updatePhotoURL(
          any(),
        ),
      ).called(1);
      verifyNever(() => authClient.currentUser!.updatePassword(any()));
      verifyNever(() => authClient.currentUser!.updateDisplayName(any()));
      verifyNever(() => authClient.currentUser!.verifyBeforeUpdateEmail(any()));
      verifyNoMoreInteractions(authClient);
    });

    test(
        'should call [remoteDatSourceImplementation.updateuser] and '
        "updates the user's password successfully(void) when no "
        '[FirebaseException] occurs', () async {
      when(() => authClient.currentUser!.updatePassword(any())).thenAnswer(
        (_) async => Future.value(),
      );

      when(() => authClient.currentUser!.email).thenReturn(tEmail);
      when(() => authClient.currentUser!.reauthenticateWithCredential(any()))
          .thenAnswer(
        (_) async => userCredential,
      );

      final call = remoteDataSourceImplementation.updateUser;

      expect(
        call(
          action: UpdateUserAction.password,
          userData: jsonEncode(
            {
              'oldPassword': '123@bob',
              'newPassword': tNewPassword,
            },
          ),
        ),
        completes,
      );

      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();
      expect(user.data()!['password'], isNull);

      // await untilCalled(
      //   () => authClient.currentUser!.updatePassword(
      //     any(),
      //   ),
      // );
      // // await untilCalled(
      // //   () => authClient.currentUser!.reauthenticateWithCredential(
      // //     any(),
      // //   ),
      // // );

      // verify(
      //   () => authClient.currentUser!.updatePassword(
      //     tNewPassword,
      //   ),
      // ).called(1);

      verifyNever(() => authClient.currentUser!.updatePhotoURL(any()));
      verifyNever(() => authClient.currentUser!.updateDisplayName(any()));
      verifyNever(() => authClient.currentUser!.verifyBeforeUpdateEmail(any()));
      verifyNoMoreInteractions(authClient);
    });

    test(
        'should call [remoteDatSourceImplementation.updateuser] and '
        "updates the user's bio successfully(void) when no "
        '[FirebaseException] occurs', () async {
      const tBio = 'new bio';
      final call = remoteDataSourceImplementation.updateUser;

      expect(
        call(
          action: UpdateUserAction.bio,
          userData: tBio,
        ),
        completes,
      );

      final user = await cloudStoreClient
          .collection('users')
          .doc(authClient.currentUser!.uid)
          .get();
      expect(user.data()!['bio'], tBio);

      verifyZeroInteractions(authClient);
    });
  });
}

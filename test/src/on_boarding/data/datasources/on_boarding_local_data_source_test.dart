import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSourceImplementation localDataSourceImplementation;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSourceImplementation = OnBoardingLocalDataSourceImplementation(
      prefs,
    );
  });

  test('should be a subclass of [OnBoardingLocalDataSource]', () {
    expect(localDataSourceImplementation, isA<OnBoardingLocalDataSource>());
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache data', () async {
      when(() => prefs.setBool(any(), any())).thenAnswer(
        (_) async => true,
      );

      await localDataSourceImplementation.cacheFirstTimer();

      verify(() => prefs.setBool(kFirstTimer, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
    test('should throw [CacheException] when failing to cache data', () async {
      when(() => prefs.setBool(any(), any())).thenThrow(
        Exception(),
      );

      final call = localDataSourceImplementation.cacheFirstTimer;
      expect(call(), throwsA(isA<CacheException>()));

      verify(() => prefs.setBool(kFirstTimer, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfuserIsFirstTimer', () {
    test('should return [true] when user is first timer', () async {
      when(() => prefs.getBool(any())).thenReturn(null);

      final result =
          await localDataSourceImplementation.checkIfUserIsFirstTimer();

      expect(result, equals(true));

      verify(() => prefs.getBool(kFirstTimer)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return [false] when user is first timer', () async {
      when(() => prefs.getBool(any())).thenReturn(false);

      final result =
          await localDataSourceImplementation.checkIfUserIsFirstTimer();

      expect(result, equals(false));
      verify(() => prefs.getBool(kFirstTimer)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw [CacheException] when failing to check if user is first '
        'timer or not', () async {
      when(() => prefs.getBool(any())).thenThrow(
        Exception(),
      );
      final call = localDataSourceImplementation.checkIfUserIsFirstTimer;

      expect(call(), throwsA(isA<CacheException>()));
      verify(() => prefs.getBool(kFirstTimer)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}

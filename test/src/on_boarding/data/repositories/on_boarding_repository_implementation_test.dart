import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/repositories/on_boarding_repository_implementation.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepositoryImplementation repositoryImplementation;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repositoryImplementation = OnBoardingRepositoryImplementation(
      localDataSource,
    );
  });

  const tCacheException = CacheException(message: 'Insufficient storage');

  test('should be a subclass of [OnBoardingRepository]', () {
    expect(repositoryImplementation, isA<OnBoardingRepository>());
  });

  group('cacheFirstTimer', () {
    test(
      'should call [localDataSource.cacheFirstTimer] and completes '
      'successfully when the call to the local data source is successfull',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repositoryImplementation.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should throw [CacheFailure] when the call to the local data source is '
      'unsuccessfull',
      () async {
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          tCacheException,
        );

        final result = await repositoryImplementation.cacheFirstTimer();

        expect(
          result,
          equals(
            left<CacheFailure, dynamic>(
              CacheFailure(
                message: tCacheException.message,
              ),
            ),
          ),
        );

        verify(() => localDataSource.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call [localDataSource.checkIfUserIsFirstTimer] and completes '
        'successfully when the call to the local data source is successful',
        () async {
      when(() => localDataSource.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => true,
      );

      final result = await repositoryImplementation.checkIfUserIsFirstTimer();

      expect(result, const Right<dynamic, bool>(true));
      verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should throw [CacheFailure] when the call to the local source is '
        'unsuccessful', () async {
      when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
        tCacheException,
      );

      final result = await repositoryImplementation.checkIfUserIsFirstTimer();

      expect(
        result,
        Left<CacheFailure, dynamic>(
          CacheFailure(
            message: tCacheException.message,
          ),
        ),
      );
      verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}

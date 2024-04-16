import 'package:dartz/dartz.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository_mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CacheFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepository();
    usecase = CacheFirstTimer(repository);
  });

  test(
    'should call [OnBoardingRepository.cacheFirstTimer] and return the right '
    'data(void)',
    () async {
      when(() => repository.cacheFirstTimer()).thenAnswer(
        (_) async => const Right(
          null,
        ),
      );

      final result = await usecase();
      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}

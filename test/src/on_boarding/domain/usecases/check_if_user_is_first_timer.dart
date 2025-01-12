import 'package:dartz/dartz.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'on_boarding_repository_mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepository();
    usecase = CheckIfUserIsFirstTimer(repository);
  });

  test(
    'should call [OnBoardingRepository.checkIfuserIsFirstTimer] and return '
    'the right data(bool)',
    () async {
      when(() => repository.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => const Right(
          true,
        ),
      );

      final result = await usecase();
      expect(result, equals(const Right<dynamic, bool>(true)));

      verify(() => repository.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}

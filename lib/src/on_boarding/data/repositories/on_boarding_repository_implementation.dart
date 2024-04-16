import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepositoryImplementation implements OnBoardingRepository {
  const OnBoardingRepositoryImplementation(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      await _localDataSource.checkIfUserIsFirstTimer();
      return const Right(true);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
        ),
      );
    }
  }
}

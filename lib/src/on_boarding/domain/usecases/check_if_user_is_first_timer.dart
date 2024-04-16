import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repository);

  final OnBoardingRepository _repository;
  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}

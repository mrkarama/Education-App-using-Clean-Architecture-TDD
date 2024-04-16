import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.forgotPassword(params);
}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be ${statusCode.runtimeType}',
        );

  String get errorMessage => 'Error: $message statusCode: $statusCode';

  final String message;
  final dynamic statusCode;

  @override
  List<dynamic> get props => [
        message,
        statusCode,
      ];
}

class CacheFailure extends Failure {
  CacheFailure({
    required super.message,
    super.statusCode = 500,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });
}

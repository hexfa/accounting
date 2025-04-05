// lib/core/use_cases/base_use_case.dart
import 'package:dartz/dartz.dart' show Either;
import 'package:accounting/core/errors/failures.dart';

abstract class BaseUseCaseNoParams<Type> {
  Future<Either<Failure, Type>> execute();
}

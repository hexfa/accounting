import 'package:dartz/dartz.dart';
import 'package:accounting/core/errors/failures.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

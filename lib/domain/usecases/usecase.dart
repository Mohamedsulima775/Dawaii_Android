

// domain/usecases/usecase.dart

import 'package:dartz/dartz.dart';
import 'package:dawaii/core/errors/failures.dart';

/// Base UseCase interface
/// [Type] هو نوع البيانات المُرجعة
/// [Params] هي المدخلات المطلوبة
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// UseCase بدون parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}
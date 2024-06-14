import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Exception, Type>> call(Params params) async {
    try {
      return Right(await execute(params));
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Future<Type> execute(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

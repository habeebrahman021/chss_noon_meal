import 'package:either_dart/either.dart';

extension EitherExtension<E, T> on Either<E, T> {
  T? rightOrNull() {
    if (isRight) return right;
    return null;
  }
}

class ValidationException implements Exception {
  ValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FailureException implements Exception {
  FailureException(this.message);

  final String message;

  @override
  String toString() => message;
}

enum Status {
  initial,
  loading,
  success,
  failure;
}

extension StatusExtension on Status {
  bool get isLoading => this == Status.loading;

  bool get isSuccess => this == Status.success;

  bool get isFailure => this == Status.failure;
}

part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.logoutStatus = Status.initial,
  });

  final Status logoutStatus;

  @override
  List<Object?> get props => [
        logoutStatus,
      ];

  HomeState copyWith({
    Status? logoutStatus,
  }) {
    return HomeState(
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }
}

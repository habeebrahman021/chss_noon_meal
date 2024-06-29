part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeEventInitial extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetStudentEntryCount extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LogoutButtonPressed extends HomeEvent {
  @override
  List<Object?> get props => [];
}

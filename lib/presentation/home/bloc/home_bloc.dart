import 'package:chss_noon_meal/core/enum/status.dart';
import 'package:chss_noon_meal/domain/use_case/auth/logout_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.logoutUseCase,
  }) : super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  final LogoutUseCase logoutUseCase;

  Future<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<HomeState> emit,
  ) async {
    final result = await logoutUseCase(NoParams());
    if (result.isRight) {
      emit(state.copyWith(logoutStatus: Status.success));
    } else {
      emit(state.copyWith(logoutStatus: Status.failure));
    }
  }
}

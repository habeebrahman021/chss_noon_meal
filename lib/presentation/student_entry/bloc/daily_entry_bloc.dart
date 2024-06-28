import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/use_case/config/get_class_list_use_case.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'daily_entry_event.dart';

part 'daily_entry_state.dart';

class DailyEntryBloc extends Bloc<DailyEntryEvent, DailyEntryState> {
  DailyEntryBloc({
    required this.getClassListUseCase,
  }) : super(const DailyEntryState()) {
    on<DailyEntryEvent>((event, emit) {});
    on<GetClassList>(_onGetClassList);
  }

  final GetClassListUseCase getClassListUseCase;

  Future<void> _onGetClassList(
    GetClassList event,
    Emitter<DailyEntryState> emit,
  ) async {
    final result = await getClassListUseCase(NoParams());
    if (result.isRight) {
      emit(state.copyWith(classList: result.right));
    }
  }
}

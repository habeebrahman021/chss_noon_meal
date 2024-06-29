import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';

class GetSavedUserRoleUseCase extends UseCase<int, NoParams> {
  GetSavedUserRoleUseCase({required this.preferenceDataSource});

  final PreferenceDataSource preferenceDataSource;

  @override
  Future<int> execute(NoParams params) {
    return preferenceDataSource.getUserRole();
  }
}

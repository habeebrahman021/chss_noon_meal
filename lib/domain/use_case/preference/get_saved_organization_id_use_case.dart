import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';

class GetSavedOrganizationIdUseCase extends UseCase<String, NoParams> {
  GetSavedOrganizationIdUseCase({required this.preferenceDataSource});

  final PreferenceDataSource preferenceDataSource;

  @override
  Future<String> execute(NoParams params) {
    return preferenceDataSource.getOrganizationId();
  }
}

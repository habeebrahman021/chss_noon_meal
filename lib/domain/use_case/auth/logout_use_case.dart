import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  LogoutUseCase({required this.preferenceDataSource});

  final PreferenceDataSource preferenceDataSource;

  @override
  Future<void> execute(NoParams params) async {
    await preferenceDataSource.clearUserId();
    await preferenceDataSource.clearUerName();
    await preferenceDataSource.clearFullName();
    await preferenceDataSource.clearProfileImage();
    await preferenceDataSource.clearClassId();
    await preferenceDataSource.clearDivisionId();
    await preferenceDataSource.clearOrganizationId();
    await preferenceDataSource.clearUserRole();
  }
}

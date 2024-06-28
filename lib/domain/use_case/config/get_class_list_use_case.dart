import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/data/repository/config_repository.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';

class GetClassListUseCase extends UseCase<List<ClassData>, NoParams> {
  GetClassListUseCase({
    required this.repository,
    required this.preferenceDataSource,
  });

  final ConfigRepository repository;

  final PreferenceDataSource preferenceDataSource;

  @override
  Future<List<ClassData>> execute(NoParams params) async {
    final organizationId = await preferenceDataSource.getOrganizationId();
    return repository.getClassList(
      organizationId: organizationId,
    );
  }
}

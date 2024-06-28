import 'package:chss_noon_meal/data/data_source/remote/config_data_source.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data.dart';
import 'package:chss_noon_meal/domain/entity/config/class_data_extension.dart';

abstract class ConfigRepository {
  Future<List<ClassData>> getClassList({
    required String organizationId,
  });
}

class DefaultConfigRepository implements ConfigRepository {
  DefaultConfigRepository({
    required this.dataSource,
  });

  final ConfigDataSource dataSource;

  @override
  Future<List<ClassData>> getClassList({
    required String organizationId,
  }) async {
    final result = await dataSource.getClassList(
      organizationId: organizationId,
    );

    return result.toEntityList();
  }
}

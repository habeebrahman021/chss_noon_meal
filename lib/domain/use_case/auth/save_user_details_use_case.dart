import 'package:chss_noon_meal/data/data_source/local/preference/preference_data_source.dart';
import 'package:chss_noon_meal/domain/entity/auth/user.dart';
import 'package:chss_noon_meal/domain/use_case/use_case.dart';
import 'package:equatable/equatable.dart';

class SaveUserDetailsUseCase
    extends UseCase<void, SaveUserDetailsUseCaseParams> {
  SaveUserDetailsUseCase({required this.preferenceDataSource});

  final PreferenceDataSource preferenceDataSource;

  @override
  Future<void> execute(SaveUserDetailsUseCaseParams params) async {
    await preferenceDataSource.saveUserId(params.user.userId);
    await preferenceDataSource.saveUserName(params.user.userName);
    await preferenceDataSource.saveFullName(params.user.fullName);
    await preferenceDataSource.saveProfileImage(params.user.profileImage);
    await preferenceDataSource.saveClassId(params.user.classId);
    await preferenceDataSource.saveDivisionId(params.user.divisionId);
    await preferenceDataSource.saveOrganizationId(params.user.organizationId);
    await preferenceDataSource.saveUserRole(params.user.userRole);
  }
}

class SaveUserDetailsUseCaseParams extends Equatable {
  const SaveUserDetailsUseCaseParams({
    required this.user,
  });

  final User user;

  @override
  List<Object?> get props => [user];
}

import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferenceDataSource {
  Future<void> saveUserId(String value);

  Future<void> saveUserName(String value);

  Future<void> saveFullName(String value);

  Future<void> saveProfileImage(String value);

  Future<void> saveUserRole(int value);

  Future<void> saveOrganizationId(String value);

  Future<void> saveClassId(String value);

  Future<void> saveDivisionId(String value);

  Future<String> getUserId();

  Future<String> getUerName();

  Future<String> getFullName();

  Future<String> getProfileImage();

  Future<int> getUserRole();

  Future<String> getOrganizationId();

  Future<String> getClassId();

  Future<String> getDivisionId();

  Future<void> clearUserId();

  Future<void> clearUerName();

  Future<void> clearFullName();

  Future<void> clearProfileImage();

  Future<void> clearUserRole();

  Future<void> clearOrganizationId();

  Future<void> clearClassId();

  Future<void> clearDivisionId();
}

class DefaultPreferenceDataSource implements PreferenceDataSource {
  DefaultPreferenceDataSource({
    required this.storage,
  });

  final SharedPreferences storage;
  static const _keyUserId = 'user_id';
  static const _keyUserName = 'user_name';
  static const _keyFullName = 'user_full_name';
  static const _keyProfileImage = 'profile_image';
  static const _keyUserRole = 'user_role';
  static const _keyOrganizationId = 'organization_id';
  static const _keyClassId = 'class_id';
  static const _keyDivisionId = 'division_id';

  @override
  Future<String> getClassId() async {
    return storage.getString(_keyClassId) ?? '';
  }

  @override
  Future<String> getDivisionId() async {
    return storage.getString(_keyDivisionId) ?? '';
  }

  @override
  Future<String> getFullName() async {
    return storage.getString(_keyFullName) ?? '';
  }

  @override
  Future<String> getOrganizationId() async {
    return storage.getString(_keyOrganizationId) ?? '';
  }

  @override
  Future<String> getProfileImage() async {
    return storage.getString(_keyProfileImage) ?? '';
  }

  @override
  Future<String> getUerName() async {
    return storage.getString(_keyUserName) ?? '';
  }

  @override
  Future<String> getUserId() async {
    return storage.getString(_keyUserId) ?? '';
  }

  @override
  Future<int> getUserRole() async {
    return storage.getInt(_keyUserRole) ?? -1;
  }

  @override
  Future<void> saveClassId(String value) async {
    await storage.setString(_keyClassId, value);
  }

  @override
  Future<void> saveDivisionId(String value) async {
    await storage.setString(_keyDivisionId, value);
  }

  @override
  Future<void> saveFullName(String value) async {
    await storage.setString(_keyFullName, value);
  }

  @override
  Future<void> saveOrganizationId(String value) async {
    await storage.setString(_keyOrganizationId, value);
  }

  @override
  Future<void> saveProfileImage(String value) async {
    await storage.setString(_keyProfileImage, value);
  }

  @override
  Future<void> saveUserId(String value) async {
    await storage.setString(_keyUserId, value);
  }

  @override
  Future<void> saveUserName(String value) async {
    await storage.setString(_keyUserName, value);
  }

  @override
  Future<void> saveUserRole(int value) async {
    await storage.setInt(_keyUserRole, value);
  }

  @override
  Future<void> clearClassId() async {
    await storage.remove(_keyClassId);
  }

  @override
  Future<void> clearDivisionId() async {
    await storage.remove(_keyDivisionId);
  }

  @override
  Future<void> clearFullName() async {
    await storage.remove(_keyFullName);
  }

  @override
  Future<void> clearOrganizationId() async {
    await storage.remove(_keyOrganizationId);
  }

  @override
  Future<void> clearProfileImage() async {
    await storage.remove(_keyProfileImage);
  }

  @override
  Future<void> clearUerName() async {
    await storage.remove(_keyUserName);
  }

  @override
  Future<void> clearUserId() async {
    await storage.remove(_keyUserId);
  }

  @override
  Future<void> clearUserRole() async {
    await storage.remove(_keyUserRole);
  }
}

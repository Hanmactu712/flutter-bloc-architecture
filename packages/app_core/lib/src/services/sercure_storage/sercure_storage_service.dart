import 'package:app_core/src/services/sercure_storage/abstract_secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService implements ISecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService({FlutterSecureStorage? secureStorage})
    : _secureStorage =
          secureStorage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
          );

  @override
  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }
}

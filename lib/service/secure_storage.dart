import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  static const String _accessToken = "GITLAB_ACCESSTOKEN";
  static const String _emailId = "GITLAB_EMAILID";
  static const String _name = "GITLAB_NAME";
  static const String _imageUrl = "GITLAB_IMAGEURL";
  static const String _id = "GITLAB_ID";
  static const String _baseUrl = "GITLAB_BASEURL";
  static const String _projectId = "GITLAB_PROJECT_ID";

  FlutterSecureStorage secureStore = new FlutterSecureStorage();

  setAuthorization(String accessToken, String userId, String emailId, String name, String imageUrl) async {
    await secureStore.write(key: _accessToken, value: accessToken);
    await secureStore.write(key: _emailId, value: emailId);
    await secureStore.write(key: _id, value: userId);
    await secureStore.write(key: _name, value: name);
    await secureStore.write(key: _imageUrl, value: imageUrl);
  }

  setGitLabConfig(String domain, String projectId) async {
    await secureStore.write(key: _baseUrl, value: domain);
    await secureStore.write(key: _projectId, value: projectId);
  }

  Future<String> getBaseUrl() async {
    return await secureStore.read(key: _baseUrl) ?? "";
  }

  Future<String> getProjectId() async {
    return await secureStore.read(key: _projectId) ?? "";
  }

  Future<String> getAccessToken() async {
    return await secureStore.read(key: _accessToken) ?? "";
  }

  Future<String> getUserId() async {
    return await secureStore.read(key: _id) ?? "";
  }

  Future<String> getEmailId() async {
    return await secureStore.read(key: _emailId) ?? "";
  }

  Future<String> getName() async {
    return await secureStore.read(key: _name) ?? "";
  }

  Future<String> getImageUrl() async {
    return await secureStore.read(key: _imageUrl) ?? "";
  }

  clearToken() async {
    await secureStore.delete(key: _id);
    await secureStore.delete(key: _emailId);
    await secureStore.delete(key: _name);
    await secureStore.delete(key: _imageUrl);
    await secureStore.delete(key: _accessToken);
    return true;
  }

}
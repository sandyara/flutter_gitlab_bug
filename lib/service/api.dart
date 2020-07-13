import 'dart:convert';
import 'dart:io';

import 'package:flutter_gitlab_bug/model/auth_response.dart';
import 'package:flutter_gitlab_bug/model/issue.dart';
import 'package:flutter_gitlab_bug/model/upload.dart';
import 'package:flutter_gitlab_bug/model/user.dart';
import 'package:flutter_gitlab_bug/service/api_base.dart';
import 'package:flutter_gitlab_bug/service/secure_storage.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:async/async.dart' as dartAsync;
import 'package:http_parser/http_parser.dart';

class API extends ApiBase {

  SecureStorage _secureStorage = new SecureStorage();

  //
  // Login
  //
  Future<AuthResponse> login(String emailId, String password) async {
    Map<String, dynamic> params = new Map();
    params['grant_type'] = 'password';
    params['username'] = emailId;
    params['password'] = password;

    var response = await sendAsync(
      "POST",
      "/oauth/token",
      params,
    );
    if (response != null) {
      print(response.body);

      AuthResponse data = AuthResponse.fromJson(json.decode(response.body));
      await _secureStorage.setAuthorization(data.accessToken, "", "", "", "");
      User user = await userInfo();
      await _secureStorage.setAuthorization(data.accessToken, user.id.toString(), user.email, user.name, user.avatarUrl);
      return data;
    }
    return null;
  }

  Future<User> userInfo() async {
    var response = await sendAsync(
      "GET",
      "/api/v4/user",
      null,
      authentication: true
    );
    if (response != null) {
      User data = User.fromJson(json.decode(response.body));
      return data;
    }
    return null;
  }

  Future<Upload> uploadFile(File document) async {
    String projectId = await _secureStorage.getProjectId();
    String path = "/api/v4/projects/${projectId}/uploads";

    String baseUrl = await _secureStorage.getBaseUrl();
    var url = Uri.parse(baseUrl + path);
    MultipartRequest request = MultipartRequest("POST", url);
    request.fields['id'] = projectId;

    var stream = new ByteStream(dartAsync.DelegatingStream.typed(document.openRead()));
    var length = await document.length();

    var multipartFile = new MultipartFile('file', stream, length,
        filename: basename(document.path),
        contentType: new MediaType('image', 'png'));
    request.files.add(multipartFile);

    var response = await sendAsync(
        "POST",
        path,
        request,
        authentication: true
    );
    if (response != null) {
      Upload data = Upload.fromJson(json.decode(response.body));
      print(data.toJson());
      return data;
    }
    return null;
  }

  Future<IssueResponse> createIssue(String title, String description) async {
    String projectId = await _secureStorage.getProjectId();

    Map<String, dynamic> params = new Map();
    params['id'] = projectId;
    params['title'] = title;
    params['description'] = description;

    var response = await sendAsync(
        "POST",
        "/api/v4/projects/${projectId}/issues",
        params,
        authentication: true
    );
    if (response != null) {
      IssueResponse data = IssueResponse.fromJson(json.decode(response.body));
      return data;
    }
    return null;
  }


}

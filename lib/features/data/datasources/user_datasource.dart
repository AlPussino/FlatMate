import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/features/data/datasources/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/login_response.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../../core/utiles.dart';
import '../models/divisions_and_townships.dart';
import '../models/my_user.dart';
import '../models/responses/email_response.dart';
import 'package:http_parser/http_parser.dart';

abstract class UserDataSource {
  Future<MyUser?> getUserInfo();
  Future<MyUser?> refreshToken(Function call);
  Future<MyUser?> changeUserName({required String userName});
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword});
  Future<MyUser?> changeMobileNumber({required String mobileNumber});
  Future<String?> uploadProfile(File file, String? oldImageUrl);
  Future<MyUser?> addSocialContact(AddSocialContactRequest body);
  Future<EmailResponse?> removeSocialContact({required String id});
  Future<List<MyanmarData>> loadMyanmarData();
}

class UserDataSourceImpl implements UserDataSource {
  final http.Client _client;
  final TokenDataSource _tokenDataSource;

  UserDataSourceImpl(this._client, this._tokenDataSource);

  @override
  Future<MyUser?> getUserInfo() async {
    final token = _tokenDataSource.getToken();
    final resp = await _client.get(Uri.parse(kAboutMeUrl),
        headers: authHeaders(token: token!));

    if (resp.statusCode == HttpStatus.ok) {
      log("Token : ${_tokenDataSource.getToken()}");
      log("Refresh Token : ${_tokenDataSource.getRefreshToken()}");
      log("Token Expired Date : ${_tokenDataSource.getTokenExpireDate()}");
      log("User info : ${resp.body}");
      return MyUser.fromJson(json.decode(resp.body));
    } else if (resp.statusCode == HttpStatus.unauthorized) {
      final user = await refreshToken(getUserInfo);

      if (user != null) {
        return user;
      } else {
        return null;
      }
    } else {
      throw Exception(resp.body);
    }
  }

  @override
  Future<MyUser?> refreshToken(Function call) async {
    final refreshToken = _tokenDataSource.getRefreshToken();

    final resp = await _client.get(
      Uri.parse("$kRefreshTokenUrl$refreshToken"),
    );

    if (resp.statusCode == HttpStatus.ok) {
      final loginResp = LoginResponse.fromJson(json.decode(resp.body));
      await _tokenDataSource.saveToken(loginResp.token);
      await _tokenDataSource.saveRefreshToken(loginResp.refreshToken ?? '');
      await _tokenDataSource
          .saveTokenExpireDate(loginResp.expiration.toString());
      final MyUser user = await call();
      return user;
    } else if (resp.statusCode == HttpStatus.badRequest) {
      throw Exception('You need to login again because our code sucks.');
    }
    return null;
  }

  @override
  Future<MyUser?> changeUserName({required String userName}) async {
    try {
      final token = _tokenDataSource.getToken();
      final resp = await _client.put(Uri.parse(kChangeUserNameUrl),
          body: json.encode({"username": userName}),
          headers: authHeaders(token: token!));

      if (resp.statusCode == HttpStatus.ok) {
        Utils.showSuccess("Name change success.");
        return MyUser.fromJson(json.decode(resp.body));
      } else {
        Utils.showError("Name change fail.");
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      final token = _tokenDataSource.getToken();
      final resp = await _client.put(Uri.parse(kChangePasswordUrl),
          body: json.encode({
            "current_password": currentPassword,
            "new_password": newPassword,
          }),
          headers: authHeaders(token: token!));

      if (resp.statusCode == HttpStatus.ok) {
        Utils.showSuccess(json.decode(resp.body)['message']);
        return EmailResponse.fromJson(json.decode(resp.body));
      } else {
        Utils.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<MyUser?> changeMobileNumber({required String mobileNumber}) async {
    try {
      final token = _tokenDataSource.getToken();
      final resp = await _client.put(Uri.parse(kChangeMobileNumberUrl),
          body: json.encode({"mobile_number": mobileNumber}),
          headers: authHeaders(token: token!));

      if (resp.statusCode == HttpStatus.ok) {
        Utils.showSuccess("Phone number change success.");
        return MyUser.fromJson(json.decode(resp.body));
      } else {
        Utils.showError("Phone number change fail.");
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<String?> uploadProfile(File file, String? oldImageUrl) async {
    final token = _tokenDataSource.getToken();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    log("File path : ${file.path}");

    var request = http.MultipartRequest('POST', Uri.parse(kUploadProfileUrl));
    // request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath('image', file.path,
        contentType: MediaType('Auto', 'jpeg')));

    if (oldImageUrl == null) {
      request.files.add(
        http.MultipartFile.fromString('data', json.encode({'image_url': null}),
            contentType: MediaType('application', 'json')),
      );
    } else {
      request.files.add(
        http.MultipartFile.fromString(
            'data', json.encode({'image_url': oldImageUrl}),
            contentType: MediaType('application', 'json')),
      );
    }

    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == HttpStatus.ok) {
        Utils.showSuccess("Profile image upload success");
        final responseJson = jsonDecode(await response.stream.bytesToString());
        print('Response data: $responseJson');
      } else {
        log('error tat');
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occurred during the request.
      print('Error: $error');
    }
    return null;
  }

  @override
  Future<MyUser?> addSocialContact(AddSocialContactRequest body) async {
    try {
      final token = _tokenDataSource.getToken();
      final resp = await _client.post(Uri.parse(kAddSocialContactUrl),
          body: json.encode(body.toJson()),
          headers: authHeaders(token: token!));

      if (resp.statusCode == HttpStatus.ok) {
        Utils.showSuccess("Adding social contact success.");
        return MyUser.fromJson(json.decode(resp.body));
      } else {
        Utils.showError("Adding social contact fail.");
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<EmailResponse?> removeSocialContact({required String id}) async {
    try {
      final token = _tokenDataSource.getToken();
      final resp = await _client.delete(
          Uri.parse("$kRemoveSocialContactUrl$id"),
          headers: authHeaders(token: token!));

      if (resp.statusCode == HttpStatus.ok) {
        Utils.showSuccess(json.decode(resp.body)['message']);
        return EmailResponse.fromJson(json.decode(resp.body));
      } else {
        Utils.showError(json.decode(resp.body)['message']);
        return null;
      }
    } on SocketException {
      Utils.showError("Network Error");
    } catch (e) {
      log(e.toString());
      Utils.showError('err : $e');
      return null;
    }
    return null;
  }

  @override
  Future<List<MyanmarData>> loadMyanmarData() async {
    log('myanmar data method works');
    // Load the JSON file from the assets folder
    final String jsonText =
        await rootBundle.loadString('assets/jsons/divisionsAndTownships.json');
    // Parse the JSON data
    List<dynamic> jsonData = json.decode(jsonText) as List;

    final data = jsonData.map((json) => MyanmarData.fromJson(json)).toList();
    return data;
  }
}

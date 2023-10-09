import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/user_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/my_user.dart';
import 'package:finding_apartments_yangon/features/data/models/other_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/notification_pages/toast_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserDataSourceImpl implements UserDataSource {
  final http.Client client;
  final TokenDataSource tokenDataSource;

  UserDataSourceImpl(this.client, this.tokenDataSource);

  @override
  Future<MyUser?> getUserInfo() async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();
    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(Uri.parse(aboutMeUrl),
          headers: authHeaders(token: token!));

      if (response.statusCode == HttpStatus.ok) {
        return MyUser.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return null;
      } else {
        throw Exception(response.body);
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<MyUser?> changeUserName({required String userName}) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();
    try {
      final token = tokenDataSource.getToken();
      final response = await client.put(Uri.parse(changeUserNameUrl),
          body: json.encode({"username": userName}),
          headers: authHeaders(token: token!));

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess("Name change success.");
        return MyUser.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError("Name change fail.");
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword}) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    try {
      final token = tokenDataSource.getToken();
      final response = await client.put(Uri.parse(changePasswordUrl),
          body: json.encode({
            "current_password": currentPassword,
            "new_password": newPassword,
          }),
          headers: authHeaders(token: token!));

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess(json.decode(response.body)['message']);
        return EmailResponse.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<MyUser?> changeMobileNumber({required String mobileNumber}) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    try {
      final token = tokenDataSource.getToken();
      final response = await client.put(Uri.parse(changeMobileNumberUrl),
          body: json.encode({"mobile_number": mobileNumber}),
          headers: authHeaders(token: token!));

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess("Phone number change success.");
        return MyUser.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError("Phone number change fail.");
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<String?> uploadProfile(File file, String? oldImageUrl) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    log("File path : ${file.path}");

    var request = http.MultipartRequest('POST', Uri.parse(uploadProfileUrl));

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
        ToastNotificatoins.showSuccess("Profile image upload success");
        final responseJson = jsonDecode(await response.stream.bytesToString());
        return responseJson.toString();
      } else {
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<MyUser?> addSocialContact(AddSocialContactRequest body) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    try {
      final token = tokenDataSource.getToken();
      final response = await client.post(Uri.parse(addSocialContactUrl),
          body: json.encode(body.toJson()),
          headers: authHeaders(token: token!));

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess("Adding social contact success.");
        return MyUser.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError("Adding social contact fail.");
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<MyUser?> removeSocialContact({required String id}) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    try {
      final token = tokenDataSource.getToken();
      final response = await client.delete(
          Uri.parse("$removeSocialContactUrl$id"),
          headers: authHeaders(token: token!));

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess("Removing social contact success.");
        return MyUser.fromJson(json.decode(response.body));
      } else {
        ToastNotificatoins.showError("Removing social contact fail.");
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<OtherUser?> aboutOtherUser({required int userId}) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(
        Uri.parse("$aboutOtherUserUrl$userId"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        return OtherUser.fromJson(jsonDecode(response.body));
      } else {
        ToastNotificatoins.showError('Loading user info error');
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }

  @override
  Future<PostOwnerList?> searchUser({required String keyword}) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(
        Uri.parse("$searchUserUrl$keyword"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        return PostOwnerList.fromJson(response.body);
      } else {
        ToastNotificatoins.showError('Loading user info error');
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (e) {
      log(e.toString());
      ToastNotificatoins.showError('err : $e');
      return null;
    }
  }
}

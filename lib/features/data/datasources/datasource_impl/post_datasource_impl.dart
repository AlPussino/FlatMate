import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/configs/strings.dart';
import 'package:http_parser/http_parser.dart';
import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/post_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/all_posts.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/notification_pages/toast_notifications.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostDataSourceImpl implements PostDataSource {
  final http.Client client;
  final SharedPreferences pref;
  final TokenDataSource tokenDataSource;

  PostDataSourceImpl(this.client, this.pref, this.tokenDataSource);

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

  @override
  Future<Post?> createPost(List<File> imageFiles, Post body) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', Uri.parse(createPostUrl));

    for (var image in imageFiles) {
      final imageStream = http.ByteStream(image.openRead());
      final imageLength = await image.length();

      final imageUri = Uri.file(image.path);

      final multipartFile = http.MultipartFile(
          'images', // The field name for the file in the form data
          imageStream,
          imageLength,
          filename: imageUri.pathSegments.last,
          contentType: MediaType('Auto', 'jpeg'));

      request.files.add(multipartFile);
    }

    request.files.add(
      http.MultipartFile.fromString('data', json.encode(body.toJson()),
          contentType: MediaType('application', 'json')),
    );

    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess("creating post success");
        final responseJson = jsonDecode(await response.stream.bytesToString());
        return Post.fromJson(responseJson);
      } else {
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<PostList?> getMyPosts() async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(
        Uri.parse(getMyPostsUrl),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        return PostList.fromJson(response.body);
      } else {
        ToastNotificatoins.showError('Loading my posts error');
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
  Future<Post?> getPostDetail(int postId) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(
        Uri.parse("$getPostDetailUrl$postId"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        ToastNotificatoins.showError('Loading post detail error');
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
  Future<bool?> deleteMyPost(int postId) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.delete(
        Uri.parse("$deleteMyPostUrl$postId"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess(json.decode(response.body)['message']);
        return true;
      } else {
        ToastNotificatoins.showError('Deleting post error');
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
  Future<AllPosts?> getAllPosts(int? pageCursor) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(
        Uri.parse(pageCursor != null
            ? "$getAllPostsUrl$pageCursor&limit=10"
            : "$getAllPostsUrl&limit=10"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        return AllPosts.fromJson(jsonDecode(response.body));
      } else {
        ToastNotificatoins.showError('Loading all posts error');
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
  Future<Post?> saveOrUnsavePost(int postId, bool save) async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.post(
        Uri.parse(save == true
            ? "$savePostUrl$postId/save?save=true"
            : "$savePostUrl$postId/save?save=false"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        if (json.decode(response.body)['saved']) {
          ToastNotificatoins.showSuccess("Saved post");
        } else {
          ToastNotificatoins.showSuccess("Unsaved post");
        }
        return Post.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == HttpStatus.conflict) {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
        return null;
      } else if (response.statusCode == HttpStatus.badRequest) {
        ToastNotificatoins.showError(json.decode(response.body)['message']);
        return null;
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
  Future<PostList?> getSavedPosts() async {
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.get(
        Uri.parse(getSavedPostsUrl),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        return PostList.fromJson(response.body);
      } else if (response.statusCode == HttpStatus.badRequest) {
        log('bad req error');
        return null;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        log('authorization error');
        return null;
      } else {
        ToastNotificatoins.showError('Loading my saved posts error');
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
  Future<Post?> editTenants(int postId, int tenants) async {
    log("EWo");
    log(postId.toString());
    log(tenants.toString());
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();
    try {
      final response = await client.put(
        Uri.parse("$editTenantsUrl$postId?tenant=$tenants"),
        headers: authHeaders(token: token!),
      );

      if (response.statusCode == HttpStatus.ok) {
        ToastNotificatoins.showSuccess("Tenants edit success");
        return Post.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        log('bad req error');
        return null;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        log('authorization error');
        return null;
      } else {
        ToastNotificatoins.showError('Editing tenants error');
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
  Future<Post?> editPost(int postId, List<File> imageFiles, Post body) async {
    log("PostID : $postId");
    log("Images : ${imageFiles.length}");
    await tokenDataSource.refreshTokenIfTokenIsExpired();

    final token = tokenDataSource.getToken();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    var request =
        http.MultipartRequest('PUT', Uri.parse("$editPostUrl$postId"));

    for (var image in imageFiles) {
      final imageStream = http.ByteStream(image.openRead());
      final imageLength = await image.length();

      final imageUri = Uri.file(image.path);

      final multipartFile = http.MultipartFile(
        'images', // The field name for the file in the form data
        imageStream,
        imageLength,
        filename: imageUri.pathSegments.last,
        contentType: MediaType('Auto', 'jpg'),
      );

      request.files.add(multipartFile);
    }

    request.files.add(
      http.MultipartFile.fromString('data', json.encode(body.toJson()),
          contentType: MediaType('application', 'json')),
    );

    request.headers.addAll(headers);

    try {
      final response = await request.send();

      if (response.statusCode == HttpStatus.ok) {
        log('ok');
        ToastNotificatoins.showSuccess("updating post success");
        final responseJson = jsonDecode(await response.stream.bytesToString());
        return Post.fromJson(responseJson);
      } else {
        log('this error');
        return null;
      }
    } on SocketException {
      ToastNotificatoins.showError(AppString.networkError);
      return null;
    } catch (error) {
      return null;
    }
  }
}

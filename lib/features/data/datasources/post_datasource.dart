import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/api_configs.dart';
import 'package:finding_apartments_yangon/core/utiles.dart';
import 'package:finding_apartments_yangon/features/data/datasources/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

abstract class PostDataSource {
  Future<List<MyanmarData>> loadMyanmarData();
  Future<Post?> createPost(List<File> imageFiles, Post body);
  Future<PostList?> getMyPosts();
  Future<Post?> getPostDetail(int postId);
  Future<bool?> deleteMyPost(int postId);
}

class PostDataSourceImpl implements PostDataSource {
  final http.Client _client;
  final SharedPreferences pref;
  final TokenDataSource _tokenDataSource;

  PostDataSourceImpl(this._client, this.pref, this._tokenDataSource);

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
    final token = _tokenDataSource.getToken();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', Uri.parse(kCreatePostUrl));

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
        Utils.showSuccess("creating post success");
        final responseJson = jsonDecode(await response.stream.bytesToString());
        print('Response data: $responseJson');
        return Post.fromJson(responseJson);
      } else {
        log('error tat');
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

  @override
  Future<PostList?> getMyPosts() async {
    final token = _tokenDataSource.getToken();
    try {
      final resp = await _client.get(
        Uri.parse(kGetMyPostsUrl),
        headers: authHeaders(token: token!),
      );

      if (resp.statusCode == HttpStatus.ok) {
        return PostList.fromJson(resp.body);
      } else {
        Utils.showError('Loading my posts error');
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
  Future<Post?> getPostDetail(int postId) async {
    final token = _tokenDataSource.getToken();
    try {
      final resp = await _client.get(
        Uri.parse("$kGetPostDetailUrl$postId"),
        headers: authHeaders(token: token!),
      );

      if (resp.statusCode == HttpStatus.ok) {
        return Post.fromJson(jsonDecode(resp.body));
      } else {
        Utils.showError('Loading post detail error');
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
  Future<bool?> deleteMyPost(int postId) async {
    final token = _tokenDataSource.getToken();
    try {
      final resp = await _client.delete(
        Uri.parse("$kDeleteMyPostUrl$postId"),
        headers: authHeaders(token: token!),
      );

      if (resp.statusCode == HttpStatus.ok) {
        Utils.showSuccess(json.decode(resp.body)['message']);
        return true;
      } else {
        Utils.showError('Deleting post error');
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
}

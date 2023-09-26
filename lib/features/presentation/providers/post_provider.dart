import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/post_usecase.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class PostProvider with ChangeNotifier {
  final PostUseCase _postUseCase;
  final TokenUseCase _tokenUseCase;

  PostProvider(this._postUseCase, this._tokenUseCase);

  List<MyanmarData> _myanmarData = [];
  List<MyanmarData> get myanmarData => _myanmarData;
  List<File> files = [];

  PostList? _myPostList;
  PostList? get myPostList => _myPostList;

  Post? _postDetail;
  Post? get postDetail => _postDetail;

  Future<List<MyanmarData>> loadMyanmarData() async {
    final data = await _postUseCase.loadMyanmarData();
    _myanmarData = data;
    notifyListeners();
    return data;
  }

  Future<Post?> uploadImagesAndCreatePost(
      Iterable<ImageFile> images, Post body) async {
    for (var imageFile in images) {
      files.add(File(imageFile.path!));
    }
    print(files.length);
    final data = await _postUseCase.createPost(files, body);
    files.clear();
    getMyPosts();
    notifyListeners();
    print("Data : $data");
    return data;
  }

  Future<PostList?> getMyPosts() async {
    final data = await _postUseCase.getMyPosts();
    _myPostList = data;
    notifyListeners();
    return data;
  }

  Future<Post?> getPostDetail(int postId) async {
    final data = await _postUseCase.getPostDetail(postId);
    _postDetail = data;
    notifyListeners();
    return data;
  }

  Future<bool?> deleteMyPost(int postId) async {
    final data = await _postUseCase.deleteMyPost(postId);
    getMyPosts();
    notifyListeners();
    return data;
  }
}

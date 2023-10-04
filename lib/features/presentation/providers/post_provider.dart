import 'dart:io';
import 'dart:developer';
import 'package:finding_apartments_yangon/features/data/models/all_posts.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/post_usecase.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:overlay_support/overlay_support.dart';

class PostProvider with ChangeNotifier {
  final PostUseCase _postUseCase;

  PostProvider(this._postUseCase);

  List<MyanmarData> _myanmarData = [];
  List<MyanmarData> get myanmarData => _myanmarData;
  List<File> files = [];

  PostList? _myPostList;
  PostList? get myPostList => _myPostList;

  Post? _postDetail;
  Post? get postDetail => _postDetail;

  int _cursor = 1;
  int? get cursor => _cursor;

  bool? _hasNext;
  bool? get hasNext => _hasNext;

  List<Post> _allPostList = [];
  List<Post>? get allPostList => _allPostList;

  PostList? _savedPostList;
  PostList? get savedPostList => _savedPostList;

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
    log("PP : ${data}");
    getMyPosts();
    notifyListeners();
    return data;
  }

  Future<AllPosts?> getAllPosts(int? pageCursor) async {
    final data = await _postUseCase.getAllPosts(pageCursor);

    allPostList!.addAll(data!.postList!);
    _cursor = data.cursor!;
    _hasNext = data.hasNext!;
    log("has next post : ${_hasNext}");
    log("Cursor id : ${_cursor}");
    log("Total posts : ${allPostList!.length.toString()}");
    toast("Total Post : ${allPostList!.length}");
    notifyListeners();
    return data;
  }

  void clearAllPostList() {
    _allPostList.clear();
  }

  void clearSavedPostList() {
    if (savedPostList!.posts != null) {
      savedPostList!.posts!.clear();
    } else {
      null;
    }
  }

  void clearMyPostList() {
    if (_myPostList!.posts != null) {
      _myPostList!.posts!.clear();
    } else {
      null;
    }
  }

  Future<AllPosts?> refreshPosts() async {
    clearAllPostList();
    final data = getAllPosts(null);
    return data;
  }

  Future<Post?> saveOrUnsavePost(int postId, bool save) async {
    final data = await _postUseCase.saveOrUnsavePost(postId, save);
    getPostDetail(postId);
    getSavedPosts();
    notifyListeners();
    return data;
  }

  Future<PostList> getSavedPosts() async {
    final data = await _postUseCase.getSavedPosts();
    _savedPostList = data;
    notifyListeners();
    return data!;
  }
}

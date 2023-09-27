import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/post_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/all_posts.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/post_repository.dart';

abstract class PostUseCase {
  Future<List<MyanmarData>> loadMyanmarData();
  Future<Post?> createPost(List<File> imageFiles, Post body);
  Future<PostList?> getMyPosts();
  Future<Post?> getPostDetail(int postId);
  Future<bool?> deleteMyPost(int postId);
  Future<AllPosts?> getAllPosts(int? pageCursor);
}

class PostUseCaseImpl implements PostUseCase {
  final PostRepository _postRepository;
  final PostDataSource _postDataSource;

  PostUseCaseImpl(this._postRepository, this._postDataSource);

  @override
  Future<List<MyanmarData>> loadMyanmarData() async {
    return await _postRepository.loadMyanmarData();
  }

  @override
  Future<Post?> createPost(List<File> imageFiles, Post body) async {
    return await _postRepository.createPost(imageFiles, body);
  }

  @override
  Future<PostList?> getMyPosts() async {
    return await _postRepository.getMyPosts();
  }

  @override
  Future<Post?> getPostDetail(int postId) async {
    return await _postRepository.getPostDetail(postId);
  }

  @override
  Future<bool?> deleteMyPost(int postId) async {
    return await _postRepository.deleteMyPost(postId);
  }

  @override
  Future<AllPosts?> getAllPosts(int? pageCursor) async {
    return await _postRepository.getAllPosts(pageCursor);
  }
}

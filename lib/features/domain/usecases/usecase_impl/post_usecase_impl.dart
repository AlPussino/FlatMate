import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/all_posts.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/post_repository.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/post_usecase.dart';

class PostUseCaseImpl implements PostUseCase {
  final PostRepository _postRepository;

  PostUseCaseImpl(this._postRepository);

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

  @override
  Future<Post?> saveOrUnsavePost(int postId, bool save) async {
    return await _postRepository.saveOrUnsavePost(postId, save);
  }

  @override
  Future<PostList?> getSavedPosts() async {
    return await _postRepository.getSavedPosts();
  }

  @override
  Future<Post?> editTenants(int postId, int tenants) async {
    return await _postRepository.editTenants(postId, tenants);
  }
}

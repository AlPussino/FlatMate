import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/post_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/all_posts.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource postDataSource;

  PostRepositoryImpl(this.postDataSource);

  @override
  Future<List<MyanmarData>> loadMyanmarData() async {
    return await postDataSource.loadMyanmarData();
  }

  @override
  Future<Post?> createPost(List<File> imageFiles, Post body) async {
    return await postDataSource.createPost(imageFiles, body);
  }

  @override
  Future<PostList?> getMyPosts() async {
    return await postDataSource.getMyPosts();
  }

  @override
  Future<Post?> getPostDetail(int postId) async {
    return await postDataSource.getPostDetail(postId);
  }

  @override
  Future<bool?> deleteMyPost(int postId) async {
    return await postDataSource.deleteMyPost(postId);
  }

  @override
  Future<AllPosts?> getAllPosts(int? pageCursor) async {
    return await postDataSource.getAllPosts(pageCursor);
  }
}

import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/all_posts.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/post_list.dart';

abstract class PostRepository {
  Future<List<MyanmarData>> loadMyanmarData();
  Future<Post?> createPost(List<File> imageFiles, Post body);
  Future<PostList?> getMyPosts();
  Future<Post?> getPostDetail(int postId);
  Future<bool?> deleteMyPost(int postId);
  Future<AllPosts?> getAllPosts(String? pageCursor);
  Future<Post?> saveOrUnsavePost(int postId, bool save);
  Future<PostList?> getSavedPosts();
  Future<Post?> editTenants(int postId, int tenants);
  Future<Post?> editPost(int postId, List<File> imageFiles, Post body);
}

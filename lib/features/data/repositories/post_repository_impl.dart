import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/post_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
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
}

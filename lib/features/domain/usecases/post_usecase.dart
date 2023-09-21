import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/post_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/post_repository.dart';

abstract class PostUseCase {
  Future<List<MyanmarData>> loadMyanmarData();
  Future<Post?> createPost(List<File> imageFiles, Post body);
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
}

import 'dart:io';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/user_datasource.dart';
import 'package:finding_apartments_yangon/features/data/models/other_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/my_user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);
  @override
  Future<MyUser?> getUserInfo() {
    return userDataSource.getUserInfo();
  }

  @override
  Future<MyUser?> changeUserName({required String userName}) async {
    return await userDataSource.changeUserName(userName: userName);
  }

  @override
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword}) async {
    return await userDataSource.changePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }

  @override
  Future<MyUser?> changeMobileNumber({required String mobileNumber}) async {
    return await userDataSource.changeMobileNumber(mobileNumber: mobileNumber);
  }

  @override
  Future<String?> uploadProfile(File file, String? oldImageUrl) async {
    return await userDataSource.uploadProfile(file, oldImageUrl);
  }

  @override
  Future<MyUser?> addSocialContact(AddSocialContactRequest body) async {
    return await userDataSource.addSocialContact(body);
  }

  @override
  Future<MyUser?> removeSocialContact({required String id}) async {
    return await userDataSource.removeSocialContact(id: id);
  }

  @override
  Future<OtherUser?> aboutOtherUser({required int userId}) async {
    return await userDataSource.aboutOtherUser(userId: userId);
  }

  @override
  Future<PostOwnerList?> searchUser({required String keyword}) async {
    return await userDataSource.searchUser(keyword: keyword);
  }
}

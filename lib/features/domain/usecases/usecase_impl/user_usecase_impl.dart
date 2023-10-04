import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/my_user.dart';
import 'package:finding_apartments_yangon/features/data/models/other_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/user_repository.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/user_usecase.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository userRepository;

  UserUseCaseImpl(this.userRepository);

  @override
  Future<MyUser?> getUserInfo() {
    return userRepository.getUserInfo();
  }

  @override
  Future<MyUser?> changeUserName({required String userName}) async {
    return await userRepository.changeUserName(userName: userName);
  }

  @override
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword}) async {
    return await userRepository.changePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }

  @override
  Future<MyUser?> changeMobileNumber({required String mobileNumber}) async {
    return await userRepository.changeMobileNumber(mobileNumber: mobileNumber);
  }

  @override
  Future<String?> uploadProfile(File file, String? oldImageUrl) async {
    return userRepository.uploadProfile(file, oldImageUrl);
  }

  @override
  Future<MyUser?> addSocialContact(AddSocialContactRequest body) async {
    return await userRepository.addSocialContact(body);
  }

  @override
  Future<MyUser?> removeSocialContact({required String id}) async {
    return await userRepository.removeSocialContact(id: id);
  }

  @override
  Future<OtherUser?> aboutOtherUser({required int userId}) async {
    return await userRepository.aboutOtherUser(userId: userId);
  }

  @override
  Future<PostOwnerList?> searchUser({required String keyword}) async {
    return await userRepository.searchUser(keyword: keyword);
  }
}

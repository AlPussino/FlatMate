import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/my_user.dart';
import 'package:finding_apartments_yangon/features/data/models/other_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';

abstract class UserUseCase {
  Future<MyUser?> getUserInfo();
  Future<MyUser?> changeUserName({required String userName});
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword});
  Future<MyUser?> changeMobileNumber({required String mobileNumber});
  Future<String?> uploadProfile(File file, String? oldImageUrl);
  Future<MyUser?> addSocialContact(AddSocialContactRequest body);
  Future<MyUser?> removeSocialContact({required String id});
  Future<OtherUser?> aboutOtherUser({required int userId});
  Future<PostOwnerList?> searchUser({required String keyword});
}

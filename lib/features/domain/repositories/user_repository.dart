import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import '../../data/models/divisions_and_townships.dart';
import '../../data/models/my_user.dart';

abstract class UserRepository {
  Future<MyUser?> getUserInfo();
  Future<MyUser?> changeUserName({required String userName});
  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword});
  Future<MyUser?> changeMobileNumber({required String mobileNumber});
  Future<String?> uploadProfile(File file, String? oldImageUrl);
  Future<MyUser?> addSocialContact(AddSocialContactRequest body);
  Future<EmailResponse?> removeSocialContact({required String id});
  Future<List<MyanmarData>> loadMyanmarData();
}
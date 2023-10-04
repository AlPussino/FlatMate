import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/configs/colors.dart';
import 'package:finding_apartments_yangon/configs/integers.dart';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/other_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/data/models/social_contact.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/user_usecase.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/notification_pages/toast_notifications.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/my_user.dart';

class UserProvider with ChangeNotifier {
  final UserUseCase _userUseCase;

  UserProvider(this._userUseCase);

  MyUser? _myUser;
  MyUser? get user => _myUser;

  OtherUser? _otherUser;
  OtherUser? get otherUser => _otherUser;

  List<SocialContact>? _socialContactList = [];
  List<SocialContact>? get socialContactList => _socialContactList;

  List<MyanmarData> _myanmarData = [];
  List<MyanmarData> get myanmarData => _myanmarData;

  PostOwnerList? _postOwnerList;
  PostOwnerList? get postOwnerList => _postOwnerList;

  Future<MyUser?> getUserInfo() async {
    _myUser = await _userUseCase.getUserInfo();
    _socialContactList = user!.socialContacts;
    notifyListeners();
    return _myUser;
  }

  Future<MyUser?> changeUserName({required String userName}) async {
    final user = await _userUseCase.changeUserName(userName: userName);
    _myUser = user;
    notifyListeners();
    return user;
  }

  Future<EmailResponse?> changePassword(
      {required String currentPassword, required String newPassword}) async {
    _myUser = user;
    notifyListeners();

    return await _userUseCase.changePassword(
        currentPassword: currentPassword, newPassword: newPassword);
  }

  Future<MyUser?> changeMobileNumber({required String mobileNumber}) async {
    final user =
        await _userUseCase.changeMobileNumber(mobileNumber: mobileNumber);
    _myUser = user;
    notifyListeners();
    return user;
  }

  Future<String?> pickImageAndSaveToSever(
      String? oldImageUrl, bool isCamera) async {
    final pickedImg = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedImg != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImg.path,
        compressQuality: 90,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            dimmedLayerColor: AppColor.whiteColor,
            backgroundColor: AppColor.whiteColor,
            toolbarTitle: 'Edit',
            toolbarColor: AppColor.whiteColor,
            hideBottomControls: false,
            showCropGrid: true,
            statusBarColor: AppColor.whiteColor,
            activeControlsWidgetColor: const Color(0xff227143),
            toolbarWidgetColor: const Color(0xff227143),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Edit',
          ),
        ],
      );
      final finalImg = XFile(croppedFile!.path);
      final file = File(finalImg.path).readAsBytesSync();
      if (file.length > AppInteger.maxProfileImageSize) {
        ToastNotificatoins.showError(
            'Your image is greater than 20 MB, \nPlease Select another image!');
      }
      // _profileImageStr = base64Encode(File(finalImg.path).readAsBytesSync());
      // String? url = await _userUseCase.uploadProfile(File(finalImg.path),);

      String? url =
          await _userUseCase.uploadProfile(File(finalImg.path), oldImageUrl);
      user?.profileUrl = url;
      getUserInfo();
      notifyListeners();
      if (url != null) {
        ToastNotificatoins.showSuccess("New Profile Uploaded Successfully!");
        notifyListeners();
      }
      return url;
    } else {
      ToastNotificatoins.showError('Please select an image to upload.');
      return Future.value(null);
    }
  }

  Future<MyUser?> addSocialContact(AddSocialContactRequest body) async {
    final user = await _userUseCase.addSocialContact(body);
    _myUser = user;
    notifyListeners();
    return user;
  }

  Future<MyUser?> removeSocialContact({required String id}) async {
    final user = await _userUseCase.removeSocialContact(id: id);
    _myUser = user;
    log("Data => $user");
    notifyListeners();
    return user;
  }

  Future<OtherUser?> aboutOtherUser({required int userId}) async {
    final data = await _userUseCase.aboutOtherUser(userId: userId);
    _otherUser = data;
    notifyListeners();
    return data;
  }

  Future<PostOwnerList> searchUser({required String keyword}) async {
    log("call search");
    final data = await _userUseCase.searchUser(keyword: keyword);
    _postOwnerList = data;
    log("RT : ${_postOwnerList}");
    notifyListeners();
    return data!;
  }

  void clearPostOwnerList() {
    postOwnerList!.postOwners!.clear();
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:finding_apartments_yangon/features/data/models/divisions_and_townships.dart';
import 'package:finding_apartments_yangon/features/data/models/other_user.dart';
import 'package:finding_apartments_yangon/features/data/models/post_owner_list.dart';
import 'package:finding_apartments_yangon/features/data/models/requests/add_social_contact_request.dart';
import 'package:finding_apartments_yangon/features/data/models/responses/email_response.dart';
import 'package:finding_apartments_yangon/features/data/models/social_contact.dart';
import 'package:finding_apartments_yangon/features/presentation/widgets/noti_pages/notis.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../configs/strings.dart';
import '../../data/models/my_user.dart';
import '../../domain/usecases/token_usecase.dart';
import '../../domain/usecases/user_usecase.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UserProvider with ChangeNotifier {
  final UserUseCase _userUseCase;
  final TokenUseCase _tokenUseCase;

  UserProvider(this._userUseCase, this._tokenUseCase);

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
            dimmedLayerColor: Colors.white,
            backgroundColor: Colors.white,
            toolbarTitle: 'Edit',
            toolbarColor: Colors.white,
            hideBottomControls: false,
            showCropGrid: true,
            statusBarColor: Colors.white,
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
      if (file.length > maxProfileImageSize) {
        Notis.showError(
            'Your image is greater than 20 MB, \nPlease Select another image!');
      }
      // _profileImageStr = base64Encode(File(finalImg.path).readAsBytesSync());
      // String? url = await _userUseCase.uploadProfile(File(finalImg.path),);

      String? url =
          await _userUseCase.uploadProfile(File(finalImg.path), oldImageUrl);
      user?.profileUrl = url;
      notifyListeners();
      if (url != null) {
        getUserInfo();
        Notis.showSuccess("New Profile Uploaded Successfully!");

        notifyListeners();
      }
      return url;
    } else {
      Notis.showError('Please select an image to upload.');
      return Future.value(null);
    }
  }

  Future<MyUser?> addSocialContact(AddSocialContactRequest body) async {
    final user = await _userUseCase.addSocialContact(body);
    _myUser = user;
    notifyListeners();
    return user;
  }

  Future<EmailResponse?> removeSocialContact({required String id}) async {
    notifyListeners();
    return await _userUseCase.removeSocialContact(id: id);
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

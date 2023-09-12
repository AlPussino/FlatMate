import 'package:flutter/material.dart';

import '../../data/models/my_user.dart';
import '../../domain/usecases/token_usecase.dart';
import '../../domain/usecases/user_usecase.dart';

class UserProvider with ChangeNotifier {
  final UserUseCase _userUseCase;
  final TokenUseCase _tokenUseCase;

  UserProvider(this._userUseCase, this._tokenUseCase);

  MyUser? _myUser;
  MyUser? get user => _myUser;

  Future<MyUser?> getUserInfo() async {
    _myUser = await _userUseCase.getUserInfo();
    return _myUser;
  }
}

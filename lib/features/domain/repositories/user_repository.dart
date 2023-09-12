import '../../data/models/my_user.dart';

abstract class UserRepository {
  Future<MyUser?> getUserInfo();
}

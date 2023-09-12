import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';
import '../models/my_user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);
  @override
  Future<MyUser?> getUserInfo() {
    return userDataSource.getUserInfo();
  }
}

import '../../data/datasources/user_datasource.dart';
import '../../data/models/my_user.dart';
import '../repositories/user_repository.dart';

abstract class UserUseCase {
  Future<MyUser?> getUserInfo();
}

class UserUseCaseImpl implements UserUseCase {
  final UserRepository userRepository;
  final UserDataSource dataSource;

  UserUseCaseImpl(this.userRepository, this.dataSource);

  @override
  Future<MyUser?> getUserInfo() {
    return userRepository.getUserInfo();
  }
}

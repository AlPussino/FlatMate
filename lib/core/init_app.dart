import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/data/datasources/auth_datasource.dart';
import 'package:http/http.dart' as http;
import '../features/data/datasources/token_datasource.dart';
import '../features/data/datasources/user_datasource.dart';
import '../features/data/repositories/auth_repository_impl.dart';
import '../features/data/repositories/token_repository_impl.dart';
import '../features/data/repositories/user_repository_impl.dart';
import '../features/domain/repositories/auth_repository.dart';
import '../features/domain/repositories/token_repository.dart';
import '../features/domain/repositories/user_repository.dart';
import '../features/domain/usecases/auth_usecase.dart';
import '../features/domain/usecases/token_usecase.dart';
import '../features/domain/usecases/user_usecase.dart';
import '../features/presentation/providers/auth_provider.dart';
import '../features/presentation/providers/home_provider.dart';
import '../features/presentation/providers/user_provider.dart';

MultiProvider initApp(
    {required Widget child,
    required BuildContext cxt,
    required SharedPreferences pref}) {
  http.Client client = http.Client();

  TokenDataSource tokenDataSource = TokenDataSourceImpl(pref);
  TokenRepository tokenRepo = TokenRepositoryImpl(tokenDataSource);
  TokenUseCase tokenUseCase = TokenUseCaseImpl(tokenRepo);

  AuthDataSource authDataSource =
      AuthDataSourceImpl(client, pref, tokenDataSource);
  AuthRepository authRepo = AuthRepositoryImpl(authDataSource);
  AuthUseCase authUseCase = AuthUseCaseImpl(authRepo, authDataSource);

  /// User
  UserDataSource userDataSource = UserDataSourceImpl(client, tokenDataSource);
  UserRepository userRepository = UserRepositoryImpl(userDataSource);
  UserUseCase userUseCase = UserUseCaseImpl(userRepository, userDataSource);

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(
          create: (_) => AuthProvider(authUseCase, tokenDataSource)),
      ChangeNotifierProvider(
          create: (_) => UserProvider(userUseCase, tokenUseCase)),
    ],
    child: child,
  );
}

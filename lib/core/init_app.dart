import 'package:finding_apartments_yangon/features/data/datasources/datasource/auth_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/post_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/token_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource/user_datasource.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource_impl/auth_datasource_impl.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource_impl/post_datasource_impl.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource_impl/token_datasource_impl.dart';
import 'package:finding_apartments_yangon/features/data/datasources/datasource_impl/user_datasource_impl.dart';
import 'package:finding_apartments_yangon/features/data/repositories/post_repository_impl.dart';
import 'package:finding_apartments_yangon/features/domain/repositories/post_repository.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/auth_usecase.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/post_usecase.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase/user_usecase.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase_impl/auth_usecase_impl.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase_impl/post_usecase_impl.dart';
import 'package:finding_apartments_yangon/features/domain/usecases/usecase_impl/user_usecase_impl.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/post_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/token_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/log_in_providers/log_in_provider.dart';
import 'package:finding_apartments_yangon/features/presentation/providers/ui_providers/profile_providers/edit_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../features/data/repositories/auth_repository_impl.dart';
import '../features/data/repositories/user_repository_impl.dart';
import '../features/domain/repositories/auth_repository.dart';
import '../features/domain/repositories/user_repository.dart';
import '../features/presentation/providers/auth_provider.dart';
import '../features/presentation/providers/home_provider.dart';
import '../features/presentation/providers/user_provider.dart';

MultiProvider initApp(
    {required Widget child,
    required BuildContext cxt,
    required SharedPreferences pref}) {
  http.Client client = http.Client();

  ///Token
  TokenDataSource tokenDataSource = TokenDataSourceImpl(client, pref);

  ///Authentication
  AuthDataSource authDataSource =
      AuthDataSourceImpl(client, pref, tokenDataSource);
  AuthRepository authRepo = AuthRepositoryImpl(authDataSource);
  AuthUseCase authUseCase = AuthUseCaseImpl(authRepo);

  /// User
  UserDataSource userDataSource = UserDataSourceImpl(client, tokenDataSource);
  UserRepository userRepository = UserRepositoryImpl(userDataSource);
  UserUseCase userUseCase = UserUseCaseImpl(userRepository);

  /// Post
  PostDataSource postDataSource =
      PostDataSourceImpl(client, pref, tokenDataSource);
  PostRepository postRepository = PostRepositoryImpl(postDataSource);
  PostUseCase postUseCase = PostUseCaseImpl(postRepository);

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider(authUseCase)),
      ChangeNotifierProvider(create: (_) => UserProvider(userUseCase)),
      ChangeNotifierProvider(create: (_) => PostProvider(postUseCase)),
      ChangeNotifierProvider(create: (_) => TokenProvider(tokenDataSource)),

      // UI providers
      ChangeNotifierProvider(create: (_) => EditPostProvider()),
      ChangeNotifierProvider(create: (_) => LogInProvider()),
    ],
    child: child,
  );
}

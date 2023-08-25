import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/presentation/providers/home_provider.dart';

MultiProvider initApp(
    {required Widget child,
    required BuildContext cxt,
    required SharedPreferences pref}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
    ],
    child: child,
  );
}

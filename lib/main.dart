import 'package:finding_apartments_yangon/core/init_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // make statusBar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final pref = await SharedPreferences.getInstance();
  runApp(MyApp(pref: pref));
}

class MyApp extends StatelessWidget {
  final SharedPreferences pref;
  MyApp({super.key, required this.pref});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: initApp(
        pref: pref,
        cxt: context,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Find Apartments Yangon',
          // theme: ThemeData(
          //     // colorScheme:
          //     //     ColorScheme.fromSeed(seedColor: const Color(0xffF2AE00)),
          //     // useMaterial3: true,
          //     ),

          home: const SplashPage(),
        ),
      ),
    );
  }
}

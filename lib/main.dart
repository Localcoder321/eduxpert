import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eduxpert/core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //InAppWebViewStatic.register();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

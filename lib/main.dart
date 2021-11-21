import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/routes.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: MaterialApp(
        home: const LoginScreen(),
        routes: routes,
      ),
    );
  }
}

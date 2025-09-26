// lib/название_приложения.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/theme/theme.dart';
import 'package:flutter_application_1/app/router/router.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Название приложения',
      //theme: AppTheme.lightTheme,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

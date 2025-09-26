// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/название_приложения.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };

  runApp(const AppName());
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/название_приложения.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Инициализация DI
  await setupLocator();

  // Bloc observer (логирование событий/состояний через talker)
  Bloc.observer = TalkerBlocObserver(talker: talker);

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  runApp(const AppName());
}

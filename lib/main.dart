import 'package:flutter/material.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/название_приложения.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  // Bloc observer (логирование событий/состояний через talker)
  Bloc.observer = TalkerBlocObserver(talker: talker);

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  runApp(const AppName());
}

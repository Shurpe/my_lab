import 'package:flutter_application_1/app/data/dio/set_up.dart';
import 'package:flutter_application_1/app/features/details/details_bloc.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/domain/repositories/content/content_repository.dart';
import 'package:flutter_application_1/domain/repositories/content/content_repository_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  // логгер
  getIt.registerSingleton<Talker>(talker);

  // настройка Dio
  setUpDio(); // из set_up.dart

  // регистрация Dio
  getIt.registerSingleton<Dio>(dio);

  // репозиторий
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: getIt<Dio>()),
  );

  // BLoC
  getIt.registerSingleton<HomeBloc>(
    HomeBloc(getIt<ContentRepositoryInterface>()),
  );
  // Новый блок для экрана деталей
  getIt.registerSingleton<DetailsBloc>(
    DetailsBloc(getIt<ContentRepositoryInterface>()),
  );
}

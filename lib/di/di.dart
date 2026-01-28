import 'package:dio/dio.dart';
import 'package:flutter_application_1/app/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/app/features/favorites/bloc/favorites_bloc.dart';
import 'package:flutter_application_1/app/features/favorites/favorites_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:flutter_application_1/app/data/dio/set_up.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/app/features/details/details_bloc.dart';
import 'package:flutter_application_1/app/auth/servise/auth_service.dart';

import 'package:flutter_application_1/domain/repositories/content/content_repository.dart';
import 'package:flutter_application_1/domain/repositories/content/content_repository_interface.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();

Future<void> setupLocator() async {
  // 🔹 Logger
  getIt.registerSingleton<Talker>(talker);

  // 🔹 Dio
  setUpDio();
  getIt.registerSingleton<Dio>(dio);

  // 🔹 Content repository
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: getIt<Dio>()),
  );

  // 🔹 Favorites repository
  getIt.registerSingleton<FavoritesRepository>(
    FavoritesRepository(),
  );

  // 🔹 Blocs
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt<ContentRepositoryInterface>()),
  );

  getIt.registerFactory<DetailsBloc>(
    () => DetailsBloc(getIt<ContentRepositoryInterface>()),
  );

  getIt.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(getIt<FavoritesRepository>()),
  );

  // 🔹 Auth
  getIt.registerSingleton<AuthServiceInterface>(AuthService());

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt<AuthServiceInterface>()),
  );
 



}




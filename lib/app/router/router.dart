import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/app/auth/auth_screen.dart';
import 'package:flutter_application_1/app/features/home/home_screen.dart';
import 'package:flutter_application_1/app/features/details/details_screen.dart';
import 'package:flutter_application_1/app/features/favorites/favorites_screen.dart';
import 'package:flutter_application_1/app/features/favorites/bloc/favorites_bloc.dart';

final _rootNavigationKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/login',
  navigatorKey: _rootNavigationKey,
  routes: [
    // Экран входа / регистрации
    GoRoute(
  path: '/login',
  name: 'login',
  builder: (context, state) => const AuthScreen(),
),


    // Главный экран
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Экран деталей
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return BlocProvider(
          create: (context) => getIt<FavoritesBloc>(),
          child: DetailsScreen(id: id),
        );
      },
    ),

    // Экран избранного
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<FavoritesBloc>()..add(LoadFavorites()),
        child: const FavoritesScreen(),
      ),
    ),
  ],
);

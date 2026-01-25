import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/app/features/home/home_screen.dart';
import 'package:flutter_application_1/app/features/details/details_screen.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    // Главный экран
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Экран деталей контента
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final idString = state.pathParameters['id'] ?? '0';
        final id = int.tryParse(idString) ?? 0;
        return DetailsScreen(id: id);
      },
    ),
  ],
);

// lib/app/router/router.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/features/home/content_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/app/features/features.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    // Если позже понадобится экран деталей, можно раскомментировать/добавить маршрут:
     GoRoute(
       path: '/content/:id',
       name: 'content',
       builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return ContentScreen(contentId: id, id: '',);
      },
     ),
  ],
);

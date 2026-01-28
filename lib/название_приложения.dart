// lib/название_приложения.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/app/router/router.dart';
import 'package:flutter_application_1/app/theme/theme_data.dart';
import 'package:flutter_application_1/di/di.dart';

// blocs
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/app/features/details/details_bloc.dart';
import 'package:flutter_application_1/app/features/favorites/bloc/favorites_bloc.dart';
import 'package:flutter_application_1/app/auth/bloc/auth_bloc.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => getIt<HomeBloc>(),
        ),
        BlocProvider<DetailsBloc>(
          create: (_) => getIt<DetailsBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => getIt<FavoritesBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Название приложения',
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}

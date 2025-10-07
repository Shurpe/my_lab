import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/extensions/extensions.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/app/features/home/content_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _home;

  @override
  void initState() {
    super.initState();
    _home = getIt<HomeBloc>();
    _home.add(const HomeLoad());
  }

  @override
  void dispose() {
    // если блок зарегистрирован как singleton в getIt, не закрываем его тут.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _home,
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoadInProgress() => const Center(child: CircularProgressIndicator()),
            HomeLoadSuccess() => _buildHomeLoadSuccess(state as HomeLoadSuccess),
            HomeLoadFailure() => _buildHomeLoadFailure(state as HomeLoadFailure),
          };
        },
      ),
    );
  }

  Widget _buildHomeLoadSuccess(HomeLoadSuccess state) {
    final content = state.content;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Header', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: content.length,
            itemBuilder: (_, index) => ContentCard(
              id: content[index].id.toString(),
              title: content[index].title,
              description: content[index].description,
              imageAsset: content[index].image, content: null,
            ),
            separatorBuilder: (_, __) => 16.ph,
          ),
        ],
      ),
    );
  }

  Widget _buildHomeLoadFailure(HomeLoadFailure state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ошибка: ${state.exception}'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () => _home.add(const HomeLoad()), child: const Text('Повторить')),
        ],
      ),
    );
  }
}

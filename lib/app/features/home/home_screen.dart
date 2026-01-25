import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app/features/home/content_card.dart';
import 'package:flutter_application_1/di/di.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<HomeBloc>()..add(HomeLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is HomeLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadSuccess) {
            final contentList = state.content;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: contentList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final content = contentList[index];
                return ContentCard(
                  id: content.id,
                  title: content.title,
                  description: content.description,
                  imageAsset: content.image,
                );
              },
            );
          } else if (state is HomeLoadFailure) {
            return Center(child: Text('Ошибка: ${state.exception}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

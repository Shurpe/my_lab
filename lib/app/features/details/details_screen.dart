import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app/features/details/details_bloc.dart';
import 'package:flutter_application_1/di/di.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<DetailsBloc>()..add(DetailsLoad(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Детали')),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            final content = state.content;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(content.title,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Image.asset(
                    content.image,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(content.description,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text('Автор: ${content.author}',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            );
          } else if (state is DetailsError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/repositories/content/model/content.dart';
import 'package:flutter_application_1/domain/repositories/content/content_repository_interface.dart';
import 'package:flutter_application_1/di/di.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ContentRepositoryInterface repository;

  DetailsBloc(this.repository) : super(DetailsInitial()) {
    on<DetailsLoad>(_onLoad);
  }

  Future<void> _onLoad(DetailsLoad event, Emitter<DetailsState> emit) async {
    emit(DetailsLoading());
    try {
      final allContent = await repository.getContent();
      final content =
          allContent.firstWhere((item) => item.id == event.id, orElse: () {
        throw Exception('Контент не найден');
      });
      emit(DetailsLoaded(content));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}
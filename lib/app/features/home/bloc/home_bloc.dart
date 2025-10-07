// lib/bloc/home_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/domain/repositories/content/model/content.dart';
import 'package:flutter_application_1/domain/repositories/content/content_repository_interface.dart';
import 'package:flutter_application_1/di/di.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ContentRepositoryInterface contentRepository;

  HomeBloc(this.contentRepository) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  Future<void> _homeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    try {
      if (state is! HomeLoadSuccess) {
        emit(HomeLoadInProgress());
      }
      final content = await contentRepository.getContent();
      emit(HomeLoadSuccess(content: content));
    } catch (exception, st) {
      emit(HomeLoadFailure(exception: exception));
      talker.handle(exception, st);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/app/features/favorites/favorites_repository.dart';
import 'package:flutter_application_1/domain/repositories/content/model/content.dart';


part 'favorites_event.dart';
part '../favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoad);
    on<AddFavorite>(_onAdd);
    on<RemoveFavorite>(_onRemove);
  }

  Future<void> _onLoad(
      LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      final data = await repository.getFavorites();
      emit(FavoritesLoaded(data));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> _onAdd(
      AddFavorite event, Emitter<FavoritesState> emit) async {
    await repository.addToFavorites(event.content);
    add(LoadFavorites());
  }

  Future<void> _onRemove(
      RemoveFavorite event, Emitter<FavoritesState> emit) async {
    await repository.removeFromFavorites(event.id);
    add(LoadFavorites());
  }
}

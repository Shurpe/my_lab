part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final Content content;
  AddFavorite(this.content);
}

class RemoveFavorite extends FavoritesEvent {
  final int id;
  RemoveFavorite(this.id);
}

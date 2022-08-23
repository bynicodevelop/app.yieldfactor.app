part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class OnInititializeFavoritesEvent extends FavoritesEvent {}

class OnLoadFavoritesEvent extends FavoritesEvent {}

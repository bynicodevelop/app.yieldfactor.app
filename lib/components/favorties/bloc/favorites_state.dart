part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitialState extends FavoritesState {
  final List<DocumentSnapshot<Map<String, dynamic>>> favorites;
  final int refresh;

  const FavoritesInitialState({
    this.favorites = const [],
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        favorites,
        refresh,
      ];
}

class LoadingFavoritesState extends FavoritesState {}

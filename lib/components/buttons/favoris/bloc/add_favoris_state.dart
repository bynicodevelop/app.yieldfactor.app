part of 'add_favoris_bloc.dart';

abstract class AddFavorisState extends Equatable {
  const AddFavorisState();

  @override
  List<Object> get props => [];
}

class AddFavorisInitialState extends AddFavorisState {
  final Key? key;
  final bool isFavorite;
  final bool isLoading;

  const AddFavorisInitialState({
    this.key,
    this.isFavorite = false,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isFavorite,
        isLoading,
      ];
}

class AddFavorisFailureState extends AddFavorisState {
  final String message;

  const AddFavorisFailureState(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

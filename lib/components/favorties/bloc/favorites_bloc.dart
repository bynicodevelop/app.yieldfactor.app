import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/repositories/stocks_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final StocksRepository stocksRepository = StocksRepository();

  FavoritesBloc() : super(const FavoritesInitialState()) {
    on<OnLoadFavoritesEvent>((event, emit) async {
      emit(LoadingFavoritesState());

      final List<DocumentSnapshot<Map<String, dynamic>>> favorites =
          await stocksRepository.getFavoritesUserTickers();

      print(favorites);
      emit(FavoritesInitialState(
        favorites: favorites,
      ));
    });
  }
}

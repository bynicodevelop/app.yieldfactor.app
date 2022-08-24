import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/repositories/stocks_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final StocksRepository stocksRepository = StocksRepository();

  SearchBloc() : super(const SearchInitialState()) {
    on<OnSearchEvent>((event, emit) async {
      emit(LoadingSearchState());

      final List<DocumentSnapshot<Map<String, dynamic>>> results =
          await stocksRepository.getStocksByQuery(event.query);

      emit(SearchInitialState(
        results: results,
      ));
    });

    on<OnClearSearchEvent>((event, emit) {
      emit(const SearchInitialState(
        results: [],
      ));
    });
  }
}

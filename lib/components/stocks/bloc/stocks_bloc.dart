import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/repositories/stocks_repository.dart';
import 'package:equatable/equatable.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  StocksBloc() : super(const StocksInitialState()) {
    final StocksRepository stocksRepository = StocksRepository();

    stocksRepository.stream.listen((List<DocumentSnapshot> stocks) {
      add(OnLoadedStocksEvent(
        stocks: stocks,
      ));
    });

    on<OnInititializeStocksEvent>((event, emit) async {
      emit(LoadingStocksState());
    });

    on<OnLoadStocksEvent>((event, emit) async {
      print("Loading stocks...");
      await stocksRepository.getStocks();
    });

    on<OnLoadedStocksEvent>((event, emit) {
      emit(StocksInitialState(
        stocks: event.stocks,
        refresh: DateTime.now().microsecondsSinceEpoch,
      ));
    });
  }
}

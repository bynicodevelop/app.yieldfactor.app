part of 'stocks_bloc.dart';

abstract class StocksState extends Equatable {
  const StocksState();

  @override
  List<Object> get props => [];
}

class StocksInitialState extends StocksState {
  final List<DocumentSnapshot> stocks;
  final int refresh;

  const StocksInitialState({
    this.stocks = const [],
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        stocks,
        refresh,
      ];
}

class LoadingStocksState extends StocksState {}

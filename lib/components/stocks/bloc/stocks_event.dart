part of 'stocks_bloc.dart';

abstract class StocksEvent extends Equatable {
  const StocksEvent();

  @override
  List<Object> get props => [];
}

class OnInititializeStocksEvent extends StocksEvent {}

class OnLoadStocksEvent extends StocksEvent {}

class OnLoadedStocksEvent extends StocksEvent {
  final List<DocumentSnapshot> stocks;

  const OnLoadedStocksEvent({
    required this.stocks,
  });

  @override
  List<Object> get props => [
        stocks,
      ];
}

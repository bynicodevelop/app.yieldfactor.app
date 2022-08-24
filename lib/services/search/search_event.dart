part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnSearchEvent extends SearchEvent {
  final String query;

  const OnSearchEvent({
    required this.query,
  });

  @override
  List<Object> get props => [
        query,
      ];
}

class OnClearSearchEvent extends SearchEvent {}

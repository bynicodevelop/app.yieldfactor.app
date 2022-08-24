part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class LoadingSearchState extends SearchState {}

class SearchInitialState extends SearchState {
  final List<DocumentSnapshot<Map<String, dynamic>>> results;

  const SearchInitialState({
    this.results = const [],
  });

  @override
  List<Object> get props => [
        results,
      ];
}

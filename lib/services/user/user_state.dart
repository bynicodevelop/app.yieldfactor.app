part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {
  final List<DocumentSnapshot> favorites;

  const UserInitialState({
    this.favorites = const [],
  });

  @override
  List<Object> get props => [
        favorites,
      ];
}

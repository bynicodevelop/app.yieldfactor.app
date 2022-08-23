import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/repositories/stocks_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final StocksRepository stocksRepository = StocksRepository();

  UserBloc() : super(const UserInitialState()) {
    on<OnLoadUserEvent>((event, emit) async {
      final List<DocumentSnapshot> favorites =
          await stocksRepository.getFavoritesUserTickers();

      emit(UserInitialState(
        favorites: favorites,
      ));
    });
  }
}

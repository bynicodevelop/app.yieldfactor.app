import 'package:bloc/bloc.dart';
import 'package:dividends_tracker_app/repositories/favoris_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_favoris_event.dart';
part 'add_favoris_state.dart';

class AddFavorisBloc extends Bloc<AddFavorisEvent, AddFavorisState> {
  final FavorisRepository favorisRepository = FavorisRepository();

  AddFavorisBloc() : super(const AddFavorisInitialState()) {
    on<OnAddFavorisEvent>((event, emit) async {
      emit(AddFavorisInitialState(
        key: event.key,
        isLoading: true,
      ));

      try {
        final bool result = await favorisRepository.addFavorite(
          event.item,
        );

        emit(AddFavorisInitialState(
          key: event.key,
          isFavorite: result,
          isLoading: false,
        ));
      } catch (error) {
        emit(AddFavorisFailureState(
          error.toString(),
        ));
      }
    });
  }
}

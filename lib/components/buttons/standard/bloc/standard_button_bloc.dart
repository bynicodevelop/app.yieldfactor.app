import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'standard_button_event.dart';
part 'standard_button_state.dart';

class StandardButtonBloc
    extends Bloc<StandardButtonEvent, StandardButtonState> {
  StandardButtonBloc() : super(StandardButtonInitialState()) {
    on<OnLoadingStandardButtonEvent>((event, emit) {
      emit(LoadingStandardButtonState(
        key: event.key,
      ));
    });

    on<OnCheckedStandardButtonEvent>((event, emit) {
      emit(CheckedStandardButtonState(
        key: event.key,
      ));
    });

    on<OnResetStandardButtonEvent>((event, emit) {
      emit(ResetStandardButtonState(
        key: event.key,
      ));

      emit(StandardButtonInitialState());
    });
  }
}

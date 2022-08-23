part of 'standard_button_bloc.dart';

abstract class StandardButtonState extends Equatable {
  const StandardButtonState();

  @override
  List<Object> get props => [];
}

class StandardButtonInitialState extends StandardButtonState {}

class LoadingStandardButtonState extends StandardButtonState {
  final Key key;

  const LoadingStandardButtonState({
    required this.key,
  });

  @override
  List<Object> get props => [
        key,
      ];
}

class CheckedStandardButtonState extends StandardButtonState {
  final Key key;

  const CheckedStandardButtonState({
    required this.key,
  });

  @override
  List<Object> get props => [
        key,
      ];
}

class ResetStandardButtonState extends StandardButtonState {
  final Key key;

  const ResetStandardButtonState({
    required this.key,
  });

  @override
  List<Object> get props => [
        key,
      ];
}

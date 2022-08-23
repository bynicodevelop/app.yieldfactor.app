part of 'standard_button_bloc.dart';

abstract class StandardButtonEvent extends Equatable {
  const StandardButtonEvent();

  @override
  List<Object> get props => [];
}

class OnLoadingStandardButtonEvent extends StandardButtonEvent {
  final Key key;

  const OnLoadingStandardButtonEvent({
    required this.key,
  });

  @override
  List<Object> get props => [
        key,
      ];
}

class OnCheckedStandardButtonEvent extends StandardButtonEvent {
  final Key key;

  const OnCheckedStandardButtonEvent({
    required this.key,
  });

  @override
  List<Object> get props => [
        key,
      ];
}

class OnResetStandardButtonEvent extends StandardButtonEvent {
  final Key key;

  const OnResetStandardButtonEvent({
    required this.key,
  });

  @override
  List<Object> get props => [
        key,
      ];
}

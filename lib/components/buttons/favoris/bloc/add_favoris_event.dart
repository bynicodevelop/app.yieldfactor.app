part of 'add_favoris_bloc.dart';

abstract class AddFavorisEvent extends Equatable {
  const AddFavorisEvent();

  @override
  List<Object> get props => [];
}

class OnAddFavorisEvent extends AddFavorisEvent {
  final Key? key;
  final Map<String, dynamic> item;

  const OnAddFavorisEvent({
    this.key,
    required this.item,
  }) : super();

  @override
  List<Object> get props => [
        item,
      ];
}

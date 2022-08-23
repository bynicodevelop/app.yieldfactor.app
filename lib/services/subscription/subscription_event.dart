part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class OnSubscribeSubscriptionEvent extends SubscriptionEvent {
  final Map<String, dynamic> item;
  final Map<String, dynamic> card;

  const OnSubscribeSubscriptionEvent({
    required this.item,
    required this.card,
  });

  @override
  List<Object> get props => [
        item,
        card,
      ];
}

class OnUnsubscribeSubscriptionEvent extends SubscriptionEvent {}

class OnResetSubscriptionEvent extends SubscriptionEvent {}

class OnForceStateSubscriptionEvent extends SubscriptionEvent {
  final String status;

  const OnForceStateSubscriptionEvent({
    required this.status,
  });

  @override
  List<Object> get props => [
        status,
      ];
}

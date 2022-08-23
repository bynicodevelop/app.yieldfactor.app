part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class SubscriptionInitialState extends SubscriptionState {}

class LoadingSubscriptionState extends SubscriptionState {}

class ActiveSubscriptionState extends SubscriptionState {}

class InactiveSubscriptionState extends SubscriptionState {}

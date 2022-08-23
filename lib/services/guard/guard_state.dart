part of 'guard_bloc.dart';

abstract class GuardState extends Equatable {
  const GuardState();

  @override
  List<Object> get props => [];
}

class GuardInitialState extends GuardState {
  final int daysLeft;
  final bool isAllowed;
  final bool isFreeTrial;
  final bool isSubscribed;
  final bool hasUnsubscribed;
  final DateTime? subscriptionEndDate;

  const GuardInitialState({
    this.daysLeft = 0,
    this.isAllowed = false,
    this.isFreeTrial = false,
    this.isSubscribed = false,
    this.hasUnsubscribed = false,
    this.subscriptionEndDate,
  });

  @override
  List<Object> get props => [
        daysLeft,
        isAllowed,
        isFreeTrial,
        isSubscribed,
      ];
}

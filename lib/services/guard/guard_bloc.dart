import 'package:bloc/bloc.dart';
import 'package:dividends_tracker_app/repositories/guard_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'guard_event.dart';
part 'guard_state.dart';

class GuardBloc extends Bloc<GuardEvent, GuardState> {
  final GuardRepository guardRepository = GuardRepository();

  GuardBloc() : super(const GuardInitialState()) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      add(OnVerifyPermissionGuardEvent());
    });

    on<OnVerifyPermissionGuardEvent>((event, emit) async {
      final int daysLeft = await guardRepository.daysLeft();
      final bool isFreeTrial = await guardRepository.isFreeTrial();
      final bool isSubscribed = await guardRepository.isSubscribed();
      final bool isAllowed = await guardRepository.isAllowed();
      final bool hasUnsubscribed = await guardRepository.hasUnsubscribed();
      final DateTime? subscriptionEndDate =
          await guardRepository.getSubscriptionEndDate();

      emit(GuardInitialState(
        daysLeft: daysLeft,
        isAllowed: isAllowed,
        isFreeTrial: isFreeTrial,
        isSubscribed: isSubscribed,
        hasUnsubscribed: hasUnsubscribed,
        subscriptionEndDate: subscriptionEndDate,
      ));
    });
  }
}

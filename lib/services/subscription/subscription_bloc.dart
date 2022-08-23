import 'package:bloc/bloc.dart';
import 'package:dividends_tracker_app/repositories/checkout_repository.dart';
import 'package:equatable/equatable.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final CheckoutRepository _checkoutRepository = CheckoutRepository();

  SubscriptionBloc() : super(SubscriptionInitialState()) {
    on<OnUnsubscribeSubscriptionEvent>((event, emit) async {
      emit(LoadingSubscriptionState());

      try {
        await _checkoutRepository.unsubscribe();

        emit(InactiveSubscriptionState());
      } catch (e) {
        // TODO: Handle error
      }
    });

    on<OnSubscribeSubscriptionEvent>((event, emit) async {
      emit(LoadingSubscriptionState());

      try {
        await _checkoutRepository.subscribe({
          "item": event.item,
          "card": event.card,
        });

        emit(ActiveSubscriptionState());
      } catch (e) {
        // TODO: Handle error
      }
    });

    on<OnResetSubscriptionEvent>((event, emit) => {
          emit(SubscriptionInitialState()),
        });

    on<OnForceStateSubscriptionEvent>((event, emit) => {
          emit(
            event.status == "active"
                ? ActiveSubscriptionState()
                : InactiveSubscriptionState(),
          ),
        });
  }
}

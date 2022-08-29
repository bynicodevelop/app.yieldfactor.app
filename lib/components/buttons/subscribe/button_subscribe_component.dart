import 'package:dividends_tracker_app/components/buttons/standard/button_standard_component.dart';
import 'package:dividends_tracker_app/components/modals/bottom_sheet/checkout/bloc/checkout_bloc.dart';
import 'package:dividends_tracker_app/config/validators/card_number_validator.dart';
import 'package:dividends_tracker_app/config/validators/cvc_code_validator.dart';
import 'package:dividends_tracker_app/config/validators/expiry_validator.dart';
import 'package:dividends_tracker_app/screens/success_subscribe_screen.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:dividends_tracker_app/services/subscription/subscription_bloc.dart';
import 'package:dividends_tracker_app/utils/notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSubscribeComponent extends StatelessWidget {
  final String label;
  final Map<String, dynamic> item;

  const ButtonSubscribeComponent({
    Key? key,
    required this.label,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, stateCheckoutBloc) {
        if (stateCheckoutBloc is ErrorSubscriptionState) {
          sendErrorNotification(
            context,
            "An error occurred, please try again later.",
          );
        }
      },
      builder: (context, stateSubscriptionBloc) {
        return BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            final CheckoutInitialState checkoutInitialState =
                state as CheckoutInitialState;

            return ButtonStandardComponent(
              onPressed: () {
                FirebaseAnalytics.instance.logAddPaymentInfo(
                  currency: item["currency"],
                  value: double.parse(item["amount"]),
                );

                if (!CardNumberInput.dirty(
                  value: checkoutInitialState.cardNumber,
                ).valid) {
                  sendErrorNotification(
                    context,
                    "Card number is invalid",
                  );
                  return;
                }

                if (!ExpiryInput.dirty(
                  value: checkoutInitialState.cardExpiry,
                ).valid) {
                  sendErrorNotification(
                    context,
                    "Card expiry is invalid",
                  );
                  return;
                }

                if (!CVCCodeInput.dirty(
                  value: checkoutInitialState.cardCvv,
                ).valid) {
                  sendErrorNotification(
                    context,
                    "Card CVC is invalid",
                  );
                  return;
                }

                context.read<SubscriptionBloc>().add(
                      OnSubscribeSubscriptionEvent(
                        item: item,
                        card: {
                          "cardNumber": checkoutInitialState.cardNumber,
                          "cardExpiry": checkoutInitialState.cardExpiry,
                          "cardCvv": checkoutInitialState.cardCvv,
                        },
                      ),
                    );
              },
              label: label,
              isLoading: stateSubscriptionBloc is LoadingSubscriptionState,
              isChecked: stateSubscriptionBloc is ActiveSubscriptionState,
              onReset: () {
                context
                    .read<SubscriptionBloc>()
                    .add(OnResetSubscriptionEvent());

                context.read<GuardBloc>().add(OnVerifyPermissionGuardEvent());

                User? user = FirebaseAuth.instance.currentUser;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessSubscribeScreen(
                      name: user!.displayName!,
                    ),
                  ),
                  (route) => false,
                );
              },
            );
          },
        );
      },
    );
  }
}

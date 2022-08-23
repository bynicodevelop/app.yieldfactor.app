import 'package:dividends_tracker_app/components/buttons/standard/button_standard_component.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:dividends_tracker_app/services/subscription/subscription_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonUnsubscribeComponent extends StatefulWidget {
  const ButtonUnsubscribeComponent({Key? key}) : super(key: key);

  @override
  State<ButtonUnsubscribeComponent> createState() =>
      _ButtonUnsubscribeComponentState();
}

class _ButtonUnsubscribeComponentState
    extends State<ButtonUnsubscribeComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        return ButtonStandardComponent(
            key: const Key('unsubscribe_button'),
            label: "Unsubscribe",
            onPressed: () => context.read<SubscriptionBloc>().add(
                  OnUnsubscribeSubscriptionEvent(),
                ),
            isLoading: state is LoadingSubscriptionState,
            isChecked: state is InactiveSubscriptionState,
            onReset: () {
              context.read<SubscriptionBloc>().add(OnResetSubscriptionEvent());

              context.read<GuardBloc>().add(OnVerifyPermissionGuardEvent());
            });
      },
    );
  }
}

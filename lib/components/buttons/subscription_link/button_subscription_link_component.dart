import 'package:dividends_tracker_app/screens/start_subscribe_screen.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonSubscriptionLinkComponent extends StatefulWidget {
  const ButtonSubscriptionLinkComponent({Key? key}) : super(key: key);

  @override
  State<ButtonSubscriptionLinkComponent> createState() =>
      _ButtonSubscriptionLinkComponentState();
}

class _ButtonSubscriptionLinkComponentState
    extends State<ButtonSubscriptionLinkComponent> {
  Future<int> _daysLeft() =>
      FirebaseAuth.instance.authStateChanges().first.then((user) {
        if (user != null) {
          return user.metadata.lastSignInTime!
              .add(const Duration(days: 8))
              .difference(DateTime.now())
              .inDays;
        } else {
          return 7;
        }
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuardBloc, GuardState>(
      builder: (context, state) {
        if (state is! GuardInitialState) {
          return const SizedBox.shrink();
        }

        final daysLeft = state.daysLeft;
        final isSubscribed = state.isSubscribed;

        return Visibility(
          visible: !isSubscribed,
          child: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StartSubscribeScreen(),
              ),
            ),
            child: Text(
              daysLeft < 0
                  ? "Subscribe"
                  : daysLeft == 0
                      ? "It's the last day"
                      : "$daysLeft days free trial",
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}

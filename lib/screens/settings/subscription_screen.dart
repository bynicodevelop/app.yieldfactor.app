import 'package:dividends_tracker_app/components/avatar/avatar_component.dart';
import 'package:dividends_tracker_app/components/buttons/unsubscribe/button_unsubscribe_component.dart';
import 'package:dividends_tracker_app/screens/start_subscribe_screen.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<GuardBloc, GuardState>(
        builder: (context, state) {
          final bool isSubscribed = (state as GuardInitialState).isSubscribed;
          final DateTime? subscriptionEndDate = state.subscriptionEndDate;
          final bool hasUnsubscribed = state.hasUnsubscribed;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 12.0,
                    ),
                    child: AvatarComponent(
                      radius: 40.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4.0,
                    ),
                    child: Text(
                      !hasUnsubscribed
                          ? "Your subscription is active"
                          : "Your subscription is not active",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: subscriptionEndDate != null,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 32.0,
                      ),
                      child: Text(
                        !hasUnsubscribed
                            ? "Your subscription renewal date is ${DateFormat('yyyy-MM-dd').format(subscriptionEndDate!)}"
                            : "Your subscription expiration date is ${DateFormat('yyyy-MM-dd').format(subscriptionEndDate!)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * .8,
                    child: !hasUnsubscribed
                        ? const ButtonUnsubscribeComponent()
                        : ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StartSubscribeScreen(),
                              ),
                            ),
                            child: const Text("Subscribe"),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:dividends_tracker_app/components/authentication/authentication_component.dart';
import 'package:dividends_tracker_app/components/avatar/avatar_component.dart';
import 'package:dividends_tracker_app/components/buttons/subscription_link/button_subscription_link_component.dart';
import 'package:dividends_tracker_app/components/stocks/list/stocks_list_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  right: _user == null ? 12.0 : 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ButtonSubscriptionLinkComponent(),
                    if (FirebaseAuth.instance.currentUser != null)
                      const AvatarComponent(
                        radius: 19,
                      )
                  ],
                ),
              ),
            ],
          ),
          body: const StocksListComponent(),
        ),
        AuthenticationComponent(
          onAuthenticated: (user) => setState(
            () => _user = user,
          ),
        ),
      ],
    );
  }
}

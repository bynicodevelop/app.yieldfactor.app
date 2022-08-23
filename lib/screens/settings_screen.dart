import 'package:dividends_tracker_app/screens/settings/profile_screen.dart';
import 'package:dividends_tracker_app/screens/settings/subscription_screen.dart';
import 'package:dividends_tracker_app/widgets/menu_list_item.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: const [
          MenuListItem(
            title: "Profile",
            subtitle: "Manage your profile",
            view: ProfileScreen(),
          ),
          MenuListItem(
            title: "Subscription",
            subtitle: "Manage your subscription",
            view: SubscriptionScreen(),
          ),
        ],
      ),
    );
  }
}

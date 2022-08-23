import 'package:dividends_tracker_app/components/avatar/avatar_component.dart';
import 'package:dividends_tracker_app/components/buttons/authentication/logout/button_authentication_logout.component.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  bottom: 30.0,
                ),
                child: AvatarComponent(
                  radius: 50.0,
                ),
              ),
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const ButtonAuthenticationLogout(
                  label: "Logout",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

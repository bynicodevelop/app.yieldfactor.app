import 'package:dividends_tracker_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ButtonAuthenticationLogout extends StatelessWidget {
  final String label;

  const ButtonAuthenticationLogout({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance.signOut().then(
              (value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              ),
            );
      },
      child: Text(
        label,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

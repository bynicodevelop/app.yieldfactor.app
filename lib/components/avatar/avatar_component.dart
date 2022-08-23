import 'package:dividends_tracker_app/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvatarComponent extends StatefulWidget {
  final double radius;

  const AvatarComponent({
    Key? key,
    this.radius = 20.0,
  }) : super(key: key);

  @override
  State<AvatarComponent> createState() => _AvatarComponentState();
}

class _AvatarComponentState extends State<AvatarComponent> {
  User? _user;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          setState(() => _user = user);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
          fullscreenDialog: true,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
      ),
      child: _user == null
          ? const Icon(Icons.person)
          : CircleAvatar(
              radius: widget.radius,
              backgroundImage: _user == null
                  ? null
                  : NetworkImage(
                      _user!.photoURL ?? "",
                    ),
            ),
    );
  }
}

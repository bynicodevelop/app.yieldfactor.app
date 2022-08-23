import 'package:dividends_tracker_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SuccessSubscribeScreen extends StatelessWidget {
  final String name;

  const SuccessSubscribeScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 50.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  child: Image.asset(
                    "assets/main-logo.png",
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Text(
                'Success',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 60.0,
              ),
              child: Text(
                'Your welcome $name, you are now subscribed to our Dividend Tracker',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                ),
                child: Text(
                  "Done",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

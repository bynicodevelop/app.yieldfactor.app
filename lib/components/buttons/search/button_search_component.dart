import 'package:dividends_tracker_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

class ButtonSearchComponent extends StatelessWidget {
  const ButtonSearchComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchScreen(),
          fullscreenDialog: true,
        ),
      ),
      icon: const Icon(Icons.search_rounded),
    );
  }
}

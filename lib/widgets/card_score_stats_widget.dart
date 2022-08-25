import 'package:flutter/material.dart';

class CardScoreStatsWidget extends StatelessWidget {
  final String score;

  const CardScoreStatsWidget({
    Key? key,
    required this.score,
  }) : super(key: key);

  String _indicator(String score) {
    if (int.parse(score) >= 80) {
      return 'very-safe';
    } else if (int.parse(score) >= 60) {
      return 'safe';
    } else if (int.parse(score) >= 40) {
      return 'risky';
    }

    return 'very-risky';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: _indicator(score) == 'very-safe'
              ? Colors.green[800]
              : _indicator(score) == 'safe'
                  ? Colors.green[500]
                  : _indicator(score) == 'risky'
                      ? Colors.green[300]
                      : Colors.green[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 60.0,
              ),
            ),
            Text(
              _indicator(score).toUpperCase(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

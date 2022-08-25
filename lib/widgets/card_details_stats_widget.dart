import 'package:flutter/material.dart';

class CardDetailsStatsWidget extends StatelessWidget {
  final String label;
  final String data;
  final String? sublabel;

  const CardDetailsStatsWidget({
    Key? key,
    required this.label,
    required this.data,
    this.sublabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            data,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: sublabel != null ? 12.0 : 0.0,
          ),
          if (sublabel != null)
            Text(
              sublabel!.toUpperCase(),
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 10.0,
                  ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:flutter/material.dart';

class StocksItemComponent extends StatelessWidget {
  final DocumentSnapshot stock;
  final GuardInitialState state;

  const StocksItemComponent({
    Key? key,
    required this.stock,
    required this.state,
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
    final Map<String, dynamic> stockData = stock.data() as Map<String, dynamic>;
    final bool isAllowed = state.isAllowed;

    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 100,
            child: !isAllowed &&
                    (_indicator(stock["dividend-safety"]) == 'very-safe' ||
                        _indicator(stock["dividend-safety"]) == 'safe')
                ? const Center(
                    child: Text("Requires subscription"),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 16.0,
                            bottom: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  stockData["name"],
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stockData["ticker"],
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: _indicator(stock["dividend-safety"]) ==
                                    'very-safe'
                                ? Colors.green[800]
                                : _indicator(stock["dividend-safety"]) == 'safe'
                                    ? Colors.green[500]
                                    : _indicator(stock["dividend-safety"]) ==
                                            'risky'
                                        ? Colors.green[300]
                                        : Colors.green[100],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                stock["dividend-safety"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 42.0,
                                ),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                _indicator(stock["dividend-safety"])
                                    .toLowerCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/components/buttons/favoris/button_favoris_component.dart';
import 'package:dividends_tracker_app/config/constants.dart';
import 'package:dividends_tracker_app/services/user/user_bloc.dart';
import 'package:dividends_tracker_app/widgets/card_details_stats_widget.dart';
import 'package:dividends_tracker_app/widgets/card_score_stats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockDetailScreen extends StatelessWidget {
  final DocumentSnapshot stock;

  const StockDetailScreen({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> stockData = stock.data() as Map<String, dynamic>;

    final List<String> scheduleDividend = stockData["payment-schedule"]
        .split(",")
        .map<String>((e) => e.trim().toString().toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              stockData["name"].toString().length > 20
                  ? "${stockData["name"].toString().substring(0, 20)}..."
                  : stockData["name"].toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 1.0,
              ),
              child: Text(
                "• ${stockData["ticker"]}",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12.0,
            ),
            child: BlocBuilder<UserBloc, UserState>(
              bloc: context.read<UserBloc>()..add(OnLoadUserEvent()),
              builder: (context, state) {
                return ButtonFavorisComponent(
                  isFavorite: (state as UserInitialState)
                      .favorites
                      .map(
                        (f) => f.id.toLowerCase(),
                      )
                      .contains(stockData["ticker"].toString().toLowerCase()),
                  item: stockData,
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 28.0,
        ),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
                childAspectRatio: 10 / 9,
                children: [
                  CardScoreStatsWidget(
                    score: stockData["dividend-safety"],
                  ),
                  CardDetailsStatsWidget(
                    label: "Dividend Streak",
                    data: "${stockData["dividend-growth-streak-(years)"]}",
                    sublabel: "Years without\na reduction",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 28.0,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 18.0,
                    ),
                    child: Text(
                      "Dividend Growth".toUpperCase(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 18,
                            color: Colors.grey[800],
                          ),
                    ),
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 5,
                crossAxisCount: 3,
                childAspectRatio: 10 / 9,
                children: [
                  CardDetailsStatsWidget(
                    label: "Latest",
                    data: stockData["dividend-growth-(latest)"]
                            .toString()
                            .isNotEmpty
                        ? "${stockData["dividend-growth-(latest)"]}%"
                        : "--",
                  ),
                  CardDetailsStatsWidget(
                    label: "Last 5 Years",
                    data: stockData["5-year-dividend-growth"]
                            .toString()
                            .isNotEmpty
                        ? "${stockData["5-year-dividend-growth"]}%"
                        : "--",
                  ),
                  CardDetailsStatsWidget(
                    label: "Last 20 Years",
                    data: stockData["20-year-dividend-growth"]
                            .toString()
                            .isNotEmpty
                        ? "${stockData["20-year-dividend-growth"]}%"
                        : "--",
                  ),
                ],
              ),
              const SizedBox(
                height: 28.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Dividens Calendar".toUpperCase(),
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                        ),
                        Text(
                          " • ${stockData["payment-frequency"]}",
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontStyle: FontStyle.italic,
                                  ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 5,
                crossAxisCount: 6,
                childAspectRatio: 1,
                children: [
                  "Jan",
                  "Feb",
                  "Mar",
                  "Apr",
                  "May",
                  "Jun",
                  "Jul",
                  "Aug",
                  "Sep",
                  "Oct",
                  "Nov",
                  "Dec"
                ]
                    .map(
                      (e) => Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 3.0,
                              ),
                              child: Text(e),
                            ),
                            CircleAvatar(
                              backgroundColor:
                                  scheduleDividend.contains(e.toLowerCase())
                                      ? kPrimaryColor
                                      : Colors.transparent,
                              radius: 4.0,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

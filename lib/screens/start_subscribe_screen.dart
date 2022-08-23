import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/components/modals/bottom_sheet/checkout/modal_bottom_sheet_checkout_component.dart';
import 'package:dividends_tracker_app/screens/terms_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartSubscribeScreen extends StatefulWidget {
  const StartSubscribeScreen({Key? key}) : super(key: key);

  @override
  State<StartSubscribeScreen> createState() => _StartSubscribeScreenState();
}

class _StartSubscribeScreenState extends State<StartSubscribeScreen> {
  String _period = "month";

  Future<int> _daysLeft() =>
      FirebaseAuth.instance.authStateChanges().first.then((user) {
        if (user != null) {
          return user.metadata.lastSignInTime!
              .add(const Duration(days: 8))
              .difference(DateTime.now())
              .inDays;
        } else {
          return 7;
        }
      });

  Future<Map<String, dynamic>> _loadPricing() async {
    DocumentSnapshot<Map<String, dynamic>> pricingDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection("settings")
            .doc("pricing")
            .get();

    return {
      "pricing": pricingDocumentSnapshot.data()!,
      "dayLast": await _daysLeft(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[800],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: _loadPricing(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }

          final Map<String, dynamic> pricing = snapshot.data!["pricing"];
          final int dayLast = snapshot.data!["dayLast"];

          double promoMonthly = (1 -
                  (double.parse(pricing["monthlyPricePromo"]) /
                      double.parse(pricing["monthlyPrice"]))) *
              100;

          double promoYearly = (1 -
                  (double.parse(pricing["yearlyPricePromo"]) /
                      double.parse(pricing["yearlyPrice"]))) *
              100;

          Map<String, dynamic> item = {
            "amount": _period == "month"
                ? pricing["monthlyPrice"]
                : pricing["yearlyPrice"],
            "period": _period,
            "currency": "USD",
          };

          if (dayLast > -1) {
            item = {
              "amount": _period == "month"
                  ? pricing["monthlyPricePromo"]
                  : pricing["yearlyPricePromo"],
              "period": _period,
              "currency": "USD",
            };
          }

          FirebaseAnalytics.instance.logViewItem(
            currency: item["currency"],
            value: double.parse(item["amount"]),
          );

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => setState(() => _period = "month"),
                        child: Text(
                          'Monthly',
                          style: TextStyle(
                            fontWeight: _period == "month"
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => _period = "year"),
                        child: Text(
                          "Yearly",
                          style: TextStyle(
                            fontWeight: _period == "year"
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 4.0,
                              ),
                              child: Text(
                                "\$",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 40,
                                      color: Colors.grey[800],
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          item["amount"],
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 100,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -7,
                                  ),
                        ),
                        Column(
                          children: [
                            const Spacer(),
                            Text(
                              _period == "month" ? "/mo" : "/year",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: dayLast > -1,
                    child: Column(
                      children: [
                        Text(
                          "-${_period == "month" ? promoMonthly.toStringAsFixed(0) : promoYearly.toStringAsFixed(0)}% if you subscribe\nbefore the end of the trial period.",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 20,
                                    color: Colors.grey[900],
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          _period == "month"
                              ? "\$${pricing["monthlyPricePromo"]} per month instead of \$${pricing["monthlyPrice"]}."
                              : "\$${pricing["yearlyPricePromo"]} per year instead of \$${pricing["yearlyPrice"]}.",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                    fontStyle: FontStyle.italic,
                                  ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Text(
                    _period == "month" ? " " : "+ 2 months free",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: Column(
                      children: <Widget>[
                        itemList(
                          context,
                          "Dividend Score Updates",
                          Icons.update,
                        ),
                        itemList(
                          context,
                          "Feature updates",
                          Icons.upgrade,
                        ),
                        itemList(
                          context,
                          "24/7 support",
                          Icons.support_agent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              ModalBottomSheetCheckoutComponent(
                            period: _period,
                            item: item,
                          ),
                          isScrollControlled: true,
                        );
                      },
                      child: const Text("Getting started"),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsScreen(),
                      ),
                    ),
                    child: const Text("Terms and conditions"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding itemList(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12.0,
            ),
            child: Icon(
              icon,
              color: Colors.grey[800],
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 20,
                  color: Colors.grey[900],
                ),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class GuardRepository {
  final int defaultDaysLeft = 8;

  // DateTime _now() => DateTime.now();
  DateTime _now() => DateTime.now().add(const Duration(days: 9));

  Future<int> daysLeft() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user != null) {
      return user.metadata.lastSignInTime!
          .add(Duration(
            days: defaultDaysLeft,
          ))
          .difference(_now())
          .inDays;
    } else {
      return 7;
    }
  }

  Future<bool> isFreeTrial() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user != null) {
      final DateTime? lastSignInTime = user.metadata.lastSignInTime;

      if (lastSignInTime != null) {
        final DateTime lastSignInTimePlus8Days = lastSignInTime.add(
          Duration(
            days: defaultDaysLeft,
          ),
        );

        final DateTime now = _now();

        return now.isBefore(lastSignInTimePlus8Days);
      }
    }

    return true;
  }

  Future<bool> isSubscribed() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user != null) {
      final IdTokenResult idTokenResult = await user.getIdTokenResult(true);

      if (!idTokenResult.claims!.containsKey("current_period_end")) {
        return false;
      }

      final currentPeriodEnd = idTokenResult.claims!["current_period_end"];

      if (currentPeriodEnd == null) {
        return false;
      }

      final DateTime currentPeriodEndDateTime =
          DateTime.fromMillisecondsSinceEpoch(
        currentPeriodEnd as int,
      );

      final now = _now();

      if (currentPeriodEndDateTime.isAfter(now)) {
        return true;
      }
    }

    return false;
  }

  Future<bool> hasUnsubscribed() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user != null) {
      final IdTokenResult idTokenResult = await user.getIdTokenResult(true);

      if (!idTokenResult.claims!.containsKey("subscribe_status")) {
        return false;
      }

      final String status = idTokenResult.claims!["subscribe_status"];

      return status == "inactive";
    }

    return false;
  }

  Future<DateTime?> getSubscriptionEndDate() async {
    User? user = await FirebaseAuth.instance.authStateChanges().first;

    if (user != null) {
      IdTokenResult idTokenResult = await user.getIdTokenResult(true);

      if (!idTokenResult.claims!.containsKey("current_period_end")) {
        return null;
      }
      final currentPeriodEnd = idTokenResult.claims!["current_period_end"];
      if (currentPeriodEnd == null) {
        return null;
      }
      return DateTime.fromMillisecondsSinceEpoch(
        currentPeriodEnd as int,
      );
    }

    return null;
  }

  Future<bool> isAllowed() async {
    final bool isFreeTrialResult = await isFreeTrial();
    final bool isSubscribedResult = await isSubscribed();

    if (isFreeTrialResult) {
      return true;
    } else if (isSubscribedResult) {
      return true;
    } else {
      return false;
    }
  }
}

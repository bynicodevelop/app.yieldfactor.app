import 'package:cloud_functions/cloud_functions.dart';
import 'package:dividends_tracker_app/exceptions/auth_user_exception.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutRepository {
  Future<void> subscribe(Map<String, dynamic> data) async {
    try {
      await FirebaseFunctions.instance
          .httpsCallable("onIntentRecurringPayment")
          .call(data);

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.getIdTokenResult(true);
      }

      FirebaseAnalytics.instance.logPurchase(
        currency: data["item"]["currency"],
        value: data["item"]["amount"],
      );
    } on FirebaseFunctionsException catch (e) {
      if (e.code == "unauthenticated") {
        throw AuthUserException(
          code: AuthUserException.unauthorized,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> unsubscribe() async {
    try {
      HttpsCallableResult result = await FirebaseFunctions.instance
          .httpsCallable("onUnsubscribe")
          .call({});
      print(result.data);
    } on FirebaseFunctionsException catch (e) {
      if (e.code == "unauthenticated") {
        throw AuthUserException(
          code: AuthUserException.unauthorized,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

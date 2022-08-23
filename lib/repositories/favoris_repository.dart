import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/exceptions/auth_user_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavorisRepository {
  Future<bool> addFavorite(Map<String, dynamic> data) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw AuthUserException(
        code: AuthUserException.unauthorized,
      );
    }

    final DocumentReference stockDocumentReference = FirebaseFirestore.instance
        .collection("stocks")
        .doc(data["ticker"].toString().toLowerCase());

    final DocumentSnapshot<Map<String, dynamic>> stockDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("favorites")
            .doc(data["ticker"].toString().toLowerCase())
            .get();

    if (stockDocumentSnapshot.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("favorites")
          .doc(data["ticker"].toString().toLowerCase())
          .delete();

      return false;
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("favorites")
          .doc(data["ticker"].toString().toLowerCase())
          .set({
        "ref": stockDocumentReference,
      });

      return true;
    }
  }
}

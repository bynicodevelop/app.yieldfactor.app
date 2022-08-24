import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StocksRepository {
  final StreamController<List<DocumentSnapshot>> _controller =
      StreamController();

  Stream<List<DocumentSnapshot>> get stream => _controller.stream;

  final List<DocumentSnapshot> _stocks = [];

  Future<List<DocumentSnapshot<Map<String, dynamic>>>>
      getFavoritesUserTickers() async {
    User? user = FirebaseAuth.instance.currentUser;

    final List<DocumentSnapshot<Map<String, dynamic>>> favorites = [];

    if (user != null) {
      final QuerySnapshot<Map<String, dynamic>> favoritesQuerySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('favorites')
              .get();

      favorites.addAll(await Future.wait(favoritesQuerySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> doc) async {
        final DocumentSnapshot<Map<String, dynamic>> favorite =
            await doc.data()!["ref"].get();

        return favorite;
      })));
    }

    return favorites;
  }

  Future<void> getStocks() async {
    if (_stocks.isEmpty) {
      final stocksSnapshot =
          await FirebaseFirestore.instance.collection("stocks").limit(20).get();

      for (final DocumentSnapshot value in stocksSnapshot.docs) {
        _stocks.add(value);
      }
    } else {
      final stocksSnapshot = await FirebaseFirestore.instance
          .collection("stocks")
          .startAfterDocument(_stocks[_stocks.length - 1])
          .limit(20)
          .get();

      for (final DocumentSnapshot value in stocksSnapshot.docs) {
        _stocks.add(value);
      }
    }

    _controller.add(_stocks);
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getStocksByQuery(
      String query) async {
    final List<DocumentSnapshot<Map<String, dynamic>>> stocks = [];

    final QuerySnapshot<Map<String, dynamic>> stocksByNameQuerySnapshot =
        await FirebaseFirestore.instance
            .collection("stocks")
            .where(
              "name",
              isGreaterThanOrEqualTo: query,
            )
            .limit(10)
            .get();

    final QuerySnapshot<Map<String, dynamic>> stocksByTickerQuerySnapshot =
        await FirebaseFirestore.instance
            .collection("stocks")
            .where(
              "ticker",
              isEqualTo: query.toUpperCase(),
            )
            .limit(10)
            .get();

    for (var doc in stocksByNameQuerySnapshot.docs) {
      if (!stocks.contains(doc)) {
        stocks.add(doc);
      }
    }

    for (var doc in stocksByTickerQuerySnapshot.docs) {
      if (!stocks.contains(doc)) {
        stocks.add(doc);
      }
    }

    return stocks;
  }
}

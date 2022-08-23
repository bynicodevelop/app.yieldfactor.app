import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class StocksRepository {
  final StreamController<List<DocumentSnapshot>> _controller =
      StreamController();

  Stream<List<DocumentSnapshot>> get stream => _controller.stream;

  final List<DocumentSnapshot> _stocks = [];

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
}

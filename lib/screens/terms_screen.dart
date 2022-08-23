import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  Future<String> _loadTerms() async {
    DocumentSnapshot<Map<String, dynamic>> termsDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection("settings")
            .doc("terms")
            .get();
    return termsDocumentSnapshot.get("content");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Terms"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _loadTerms(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Error loading terms"),
              );
            }

            return Markdown(
              data: snapshot.data ?? "No terms found",
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
            );
          },
        ),
      ),
    );
  }
}

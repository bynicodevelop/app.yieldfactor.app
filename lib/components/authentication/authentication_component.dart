import 'dart:ui';

import 'package:dividends_tracker_app/screens/terms_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationComponent extends StatefulWidget {
  final Function(User?) onAuthenticated;

  const AuthenticationComponent({
    Key? key,
    required this.onAuthenticated,
  }) : super(key: key);

  @override
  State<AuthenticationComponent> createState() =>
      _AuthenticationComponentState();
}

class _AuthenticationComponentState extends State<AuthenticationComponent> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      widget.onAuthenticated(user);

      if (user == null) {
        Future.delayed(const Duration(
          seconds: 6,
        )).then(
          (value) => setState(() => _visible = true),
        );
      } else {
        setState(() => _visible = false);
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: [
        'email',
      ],
    ).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: Container(
        color: Colors.white.withOpacity(.6),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            alignment: Alignment.center,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Image.asset(
                        "assets/main-logo.png",
                      ),
                    ),
                    Text(
                      "Yield Factor ™",
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "To take advantage of all the features you must be authenticated",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width - 60.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          await signInWithGoogle();

                          await FirebaseAnalytics.instance.logLogin(
                            loginMethod: "Google",
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: Image.asset(
                                "assets/logo/google_light.png",
                                height: 24.0,
                                width: 24.0,
                              ),
                            ),
                            Text(
                              "Sign in with Google",
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        letterSpacing: .9,
                                        shadows: [],
                                        color: Colors.grey[800],
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsScreen(),
                          fullscreenDialog: true,
                        ),
                      ),
                      child: Text(
                        "Term of Service",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          shadows: const [],
                          letterSpacing: .9,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

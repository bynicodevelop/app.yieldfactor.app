import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dividends_tracker_app/components/buttons/favoris/bloc/add_favoris_bloc.dart';
import 'package:dividends_tracker_app/components/buttons/standard/bloc/standard_button_bloc.dart';
import 'package:dividends_tracker_app/components/favorties/bloc/favorites_bloc.dart';
import 'package:dividends_tracker_app/components/modals/bottom_sheet/checkout/bloc/checkout_bloc.dart';
import 'package:dividends_tracker_app/components/stocks/bloc/stocks_bloc.dart';
import 'package:dividends_tracker_app/config/custom_theme_data.dart';
import 'package:dividends_tracker_app/screens/home_screen.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:dividends_tracker_app/services/notifications/notifications_bloc.dart';
import 'package:dividends_tracker_app/services/search/search_bloc.dart';
import 'package:dividends_tracker_app/services/subscription/subscription_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/services/user/user_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    FirebaseFunctions.instance.useFunctionsEmulator(
      host,
      5001,
    );
  } else {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  }

  // await FirebaseAuth.instance.signOut();

  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final NotificationsBloc notification = NotificationsBloc();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    notification.initialize();
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StandardButtonBloc>(
          create: (BuildContext context) => StandardButtonBloc(),
        ),
        BlocProvider<StocksBloc>(
          lazy: true,
          create: (BuildContext context) => StocksBloc()
            ..add(OnLoadStocksEvent())
            ..add(OnInititializeStocksEvent()),
        ),
        BlocProvider<GuardBloc>(
          lazy: true,
          create: (BuildContext context) => GuardBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (BuildContext context) => FavoritesBloc(),
        ),
        BlocProvider<CheckoutBloc>(
          create: (BuildContext context) => CheckoutBloc(),
        ),
        BlocProvider<AddFavorisBloc>(
          create: (BuildContext context) => AddFavorisBloc(),
        ),
        BlocProvider<SubscriptionBloc>(
          create: (BuildContext context) => SubscriptionBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomThemeData.themeLight(context),
        home: Builder(builder: (BuildContext context) {
          return BlocBuilder<UserBloc, UserState>(
            bloc: context.read<UserBloc>()..add(OnLoadUserEvent()),
            builder: (context, state) {
              return const HomeScreen();
            },
          );
        }),
      ),
    );
  }
}

import 'package:dividends_tracker_app/components/authentication/authentication_component.dart';
import 'package:dividends_tracker_app/components/avatar/avatar_component.dart';
import 'package:dividends_tracker_app/components/buttons/subscription_link/button_subscription_link_component.dart';
import 'package:dividends_tracker_app/components/favorties/favorites_components.dart';
import 'package:dividends_tracker_app/components/stocks/list/stocks_list_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  User? _user;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Image.asset(
                  "assets/main-logo.png",
                  height: 25,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Yield Factor ™',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  right: _user == null ? 12.0 : 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ButtonSubscriptionLinkComponent(),
                    if (FirebaseAuth.instance.currentUser != null)
                      const AvatarComponent(
                        radius: 19,
                      )
                  ],
                ),
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            children: const [
              StocksListComponent(),
              FavoritesComponent(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Stocks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_rounded),
                label: "Favorites",
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);

              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        AuthenticationComponent(
          onAuthenticated: (user) => setState(
            () => _user = user,
          ),
        ),
      ],
    );
  }
}

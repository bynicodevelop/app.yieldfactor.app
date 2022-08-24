import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/components/stocks/item/stocks_item_component.dart';
import 'package:dividends_tracker_app/config/constants.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:dividends_tracker_app/services/search/search_bloc.dart';
import 'package:dividends_tracker_app/services/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) return;

    _debounce = Timer(
        const Duration(
          milliseconds: 500,
        ), () {
      context.read<SearchBloc>().add(
            OnSearchEvent(
              query: query,
            ),
          );
    });
  }

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
      context.read<SearchBloc>().add(OnClearSearchEvent());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                  ),
                  onPressed: () => _searchController.clear(),
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is LoadingSearchState) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              }

              final List<DocumentSnapshot<Map<String, dynamic>>> searchResult =
                  (state as SearchInitialState).results;

              if (searchResult.isEmpty) {
                return const Center(
                  child: Text("No results found"),
                );
              }

              return BlocBuilder<GuardBloc, GuardState>(
                  builder: (context, state) {
                return ListView.separated(
                  // controller: _controller,
                  itemCount: searchResult.length,
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return BlocBuilder<UserBloc, UserState>(
                      bloc: context.read<UserBloc>()..add(OnLoadUserEvent()),
                      builder: (context, userState) {
                        return StocksItemComponent(
                          stock: searchResult[index],
                          state: state as GuardInitialState,
                          isFavorite: (userState as UserInitialState)
                              .favorites
                              .map(
                                (f) => f.id.toLowerCase(),
                              )
                              .contains(
                                searchResult[index].id,
                              ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                );
              });
            },
          );
        },
      ),
    );
  }
}

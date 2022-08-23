import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/components/favorties/bloc/favorites_bloc.dart';
import 'package:dividends_tracker_app/components/stocks/item/stocks_item_component.dart';
import 'package:dividends_tracker_app/config/constants.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:dividends_tracker_app/services/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesComponent extends StatelessWidget {
  const FavoritesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      bloc: context.read<FavoritesBloc>()..add(OnLoadFavoritesEvent()),
      builder: (context, state) {
        if (state is LoadingFavoritesState) {
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

        final List<DocumentSnapshot<Map<String, dynamic>>> favorites =
            (state as FavoritesInitialState).favorites;

        if (favorites.isEmpty) {
          return const Center(
            child: Text("No stocks found"),
          );
        }

        return BlocBuilder<GuardBloc, GuardState>(builder: (context, state) {
          return ListView.separated(
            // controller: _controller,
            itemCount: favorites.length,
            padding: const EdgeInsets.all(
              16.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return BlocBuilder<UserBloc, UserState>(
                bloc: context.read<UserBloc>()..add(OnLoadUserEvent()),
                builder: (context, userState) {
                  return StocksItemComponent(
                    stock: favorites[index],
                    state: state as GuardInitialState,
                    isFavorite: (userState as UserInitialState)
                        .favorites
                        .map(
                          (f) => f.id.toLowerCase(),
                        )
                        .contains(
                          favorites[index].id,
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
  }
}

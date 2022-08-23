import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dividends_tracker_app/components/stocks/bloc/stocks_bloc.dart';
import 'package:dividends_tracker_app/components/stocks/item/stocks_item_component.dart';
import 'package:dividends_tracker_app/config/constants.dart';
import 'package:dividends_tracker_app/services/guard/guard_bloc.dart';
import 'package:dividends_tracker_app/services/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksListComponent extends StatefulWidget {
  const StocksListComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<StocksListComponent> createState() => _StocksListComponentState();
}

class _StocksListComponentState extends State<StocksListComponent> {
  final ScrollController _controller = ScrollController();
  bool _isLoading = true;

  void _scrollListener() {
    if (_isLoading) {
      return;
    }

    if (_controller.offset + 200 >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() => _isLoading = true);

      context.read<StocksBloc>().add(OnLoadStocksEvent());
    }
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StocksBloc, StocksState>(
      listener: (context, state) {
        if (state is StocksInitialState) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      builder: (BuildContext context, StocksState state) {
        if (state is LoadingStocksState) {
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

        final List<DocumentSnapshot> stocks =
            (state as StocksInitialState).stocks;

        if (stocks.isEmpty) {
          return const Center(
            child: Text("No stocks found"),
          );
        }

        return BlocBuilder<GuardBloc, GuardState>(
          builder: (context, state) {
            return ListView.separated(
              controller: _controller,
              itemCount: stocks.length,
              padding: const EdgeInsets.all(
                16.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    // print((userState as UserInitialState).favorites);
                    // print(stocks[index].id);

                    return StocksItemComponent(
                        stock: stocks[index],
                        state: state as GuardInitialState,
                        isFavorite: (userState as UserInitialState)
                            .favorites
                            .map(
                              (f) => f.id.toLowerCase(),
                            )
                            .contains(stocks[index].id));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 16,
                );
              },
            );
          },
        );
      },
    );
  }
}

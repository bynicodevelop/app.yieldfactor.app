import 'package:dividends_tracker_app/components/buttons/favoris/bloc/add_favoris_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonFavorisComponent extends StatefulWidget {
  final bool isFavorite;
  final Map<String, dynamic> item;

  const ButtonFavorisComponent({
    Key? key,
    required this.isFavorite,
    required this.item,
  }) : super(key: key);

  @override
  State<ButtonFavorisComponent> createState() => _ButtonFavorisComponentState();
}

class _ButtonFavorisComponentState extends State<ButtonFavorisComponent> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddFavorisBloc, AddFavorisState>(
      listener: (context, state) {
        if (state is AddFavorisInitialState &&
            Key(widget.item["ticker"]) == state.key) {
          setState(() => _isFavorite = state.isFavorite);
        }
      },
      child: GestureDetector(
        onTap: () {
          context.read<AddFavorisBloc>().add(
                OnAddFavorisEvent(
                  key: Key(widget.item["ticker"]),
                  item: widget.item,
                ),
              );
        },
        child: Icon(
          _isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
        ),
      ),
    );
  }
}

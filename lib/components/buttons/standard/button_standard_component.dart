import 'package:dividends_tracker_app/components/buttons/standard/bloc/standard_button_bloc.dart';
import 'package:dividends_tracker_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStandardComponent extends StatefulWidget {
  final Function()? onPressed;
  final Function()? onReset;
  final String label;
  final bool isLoading;
  final bool isChecked;

  const ButtonStandardComponent({
    Key? key,
    required this.onPressed,
    this.onReset,
    required this.label,
    this.isLoading = false,
    this.isChecked = false,
  }) : super(key: key);

  @override
  State<ButtonStandardComponent> createState() =>
      _ButtonStandardComponentState();
}

class _ButtonStandardComponentState extends State<ButtonStandardComponent> {
  @override
  Widget build(BuildContext context) {
    final Key componentKey = widget.key ?? UniqueKey();

    return BlocConsumer<StandardButtonBloc, StandardButtonState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state is CheckedStandardButtonState && state.key == componentKey) {
          Future.delayed(const Duration(
            seconds: 1,
          )).then((value) {
            context.read<StandardButtonBloc>().add(
                  OnResetStandardButtonEvent(
                    key: componentKey,
                  ),
                );

            if (widget.onReset != null) {
              widget.onReset!();
            }
          });
        }
      },
      builder: (context, state) {
        if (state is! ResetStandardButtonState) {
          if (widget.isLoading) {
            context.read<StandardButtonBloc>().add(OnLoadingStandardButtonEvent(
                  key: componentKey,
                ));
          }

          if (widget.isChecked) {
            context.read<StandardButtonBloc>().add(OnCheckedStandardButtonEvent(
                  key: componentKey,
                ));
          }
        }

        return ElevatedButton(
          onPressed: widget.onPressed,
          child: state is LoadingStandardButtonState
              ? const SizedBox(
                  width: 15.0,
                  height: 15.0,
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                    strokeWidth: 2.0,
                  ),
                )
              : state is CheckedStandardButtonState
                  ? const Icon(Icons.check)
                  : Text(widget.label),
        );
      },
    );
  }
}

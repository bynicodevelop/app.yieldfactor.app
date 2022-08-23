import 'package:dividends_tracker_app/components/buttons/subscribe/button_subscribe_component.dart';
import 'package:dividends_tracker_app/components/modals/bottom_sheet/checkout/bloc/checkout_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ModalBottomSheetCheckoutComponent extends StatefulWidget {
  final String period;
  final Map<String, dynamic> item;

  const ModalBottomSheetCheckoutComponent({
    Key? key,
    required this.period,
    required this.item,
  }) : super(key: key);

  @override
  State<ModalBottomSheetCheckoutComponent> createState() =>
      _ModalBottomSheetCheckoutComponentState();
}

class _ModalBottomSheetCheckoutComponentState
    extends State<ModalBottomSheetCheckoutComponent> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();

  final FocusNode _cardNumberFocusNode = FocusNode();
  final FocusNode _cardExpiryFocusNode = FocusNode();
  final FocusNode _cardCvvFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _cardNumberController.addListener(() {
      if (_cardNumberController.text.length == 19) {
        _cardExpiryFocusNode.requestFocus();
      }

      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "cardNumber": _cardNumberController.text,
            },
          ));
    });

    _cardExpiryController.addListener(() {
      if (_cardExpiryController.text.length == 5) {
        _cardCvvFocusNode.requestFocus();
      }

      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "cardExpiry": _cardExpiryController.text,
            },
          ));
    });

    _cardCvvController.addListener(() {
      context.read<CheckoutBloc>().add(OnFormUpdatedCheckoutEvent(
            formData: {
              "cardCvv": _cardCvvController.text,
            },
          ));
    });

    _cardNumberFocusNode.requestFocus();

    if (kDebugMode) {
      _cardNumberController.text = "4242424242424242";
      _cardExpiryController.text = "12/22";
      _cardCvvController.text = "123";
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat formatCurrency = NumberFormat.currency(
      name: widget.item["currency"] == "EUR" ? "€" : "\$",
      decimalDigits: 2,
    );

    String periodName = widget.item["period"] == "month" ? "/mo" : "/year";

    return Padding(
      padding: EdgeInsets.only(
        top: 32.0,
        left: 22.0,
        right: 22.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        runSpacing: 25,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4.0,
                ),
                child: Text(
                  "Payment".toUpperCase(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Subscribe to ${formatCurrency.format(double.parse(widget.item["amount"]))} $periodName",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                    ),
                textAlign: TextAlign.center,
              )
            ],
          ),
          TextField(
            controller: _cardNumberController,
            focusNode: _cardNumberFocusNode,
            autofocus: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              CreditCardNumberInputFormatter(
                onCardSystemSelected: (cardSystem) {
                  print(cardSystem);
                },
                useSeparators: true,
              ),
            ],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 20.0,
              ),
              hintText: "XXXX XXXX XXXX XXXX",
              filled: true,
              fillColor: Colors.grey.withOpacity(.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 16.0,
                ),
                child: Icon(
                  Icons.credit_card,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _cardExpiryController,
                  focusNode: _cardExpiryFocusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    CreditCardExpirationDateFormatter(),
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 20.0,
                    ),
                    hintText: "MM/YY",
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.1),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _cardCvvController,
                  focusNode: _cardCvvFocusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    CreditCardCvcInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: "000",
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.1),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 42.0,
            ),
            child: SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ButtonSubscribeComponent(
                item: widget.item,
                label: "Subscribe",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

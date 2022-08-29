import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:formz/formz.dart';

enum CardNumberInputError { empty, invalide }

class CardNumberInput extends FormzInput<String, CardNumberInputError> {
  const CardNumberInput.pure() : super.pure('');

  const CardNumberInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CardNumberInputError? validator(String value) {
    if (value.isEmpty) {
      return CardNumberInputError.empty;
    }

    if (!isCardValidNumber(value)) {
      return CardNumberInputError.invalide;
    }

    if (value.length != 16) {
      return CardNumberInputError.invalide;
    }

    return null;
  }
}

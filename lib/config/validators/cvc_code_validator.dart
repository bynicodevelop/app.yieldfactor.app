import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum CVCCodeInputError { empty, invalide }

class CVCCodeInput extends FormzInput<String, CVCCodeInputError> {
  const CVCCodeInput.pure() : super.pure('');

  const CVCCodeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CVCCodeInputError? validator(String value) {
    if (value.isEmpty) {
      return CVCCodeInputError.empty;
    }

    if (!isNumeric(value)) {
      return CVCCodeInputError.invalide;
    }

    if (value.length != 3) {
      return CVCCodeInputError.invalide;
    }

    return null;
  }
}

part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitialState extends CheckoutState {
  final String cardNumber;
  final String cardExpiry;
  final String cardCvv;

  const CheckoutInitialState({
    this.cardNumber = "",
    this.cardExpiry = "",
    this.cardCvv = "",
  });

  CheckoutInitialState copyWith({
    String? cardNumber,
    String? cardExpiry,
    String? cardCvv,
  }) {
    return CheckoutInitialState(
      cardNumber: cardNumber ?? this.cardNumber,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      cardCvv: cardCvv ?? this.cardCvv,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cardNumber": cardNumber,
      "cardExpiry": cardExpiry,
      "cardCvv": cardCvv,
    };
  }

  @override
  List<Object> get props => [
        cardNumber,
        cardExpiry,
        cardCvv,
      ];
}

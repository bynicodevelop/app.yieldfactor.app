part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class OnFormUpdatedCheckoutEvent extends CheckoutEvent {
  final Map<String, dynamic> formData;

  const OnFormUpdatedCheckoutEvent({
    required this.formData,
  });

  @override
  List<Object> get props => [
        formData,
      ];
}

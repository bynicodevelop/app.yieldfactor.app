part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class OnMessageNotificationEvent extends NotificationsEvent {
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final bool onOpenApp;

  const OnMessageNotificationEvent({
    required this.title,
    required this.body,
    required this.data,
    this.onOpenApp = false,
  });

  @override
  List<Object> get props => [
        title,
        body,
        data,
        onOpenApp,
      ];
}

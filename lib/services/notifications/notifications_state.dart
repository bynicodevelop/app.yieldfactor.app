part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitialState extends NotificationsState {
  final Map<String, dynamic> notificationModel;
  final bool onOpenApp;

  const NotificationsInitialState({
    required this.notificationModel,
    this.onOpenApp = false,
  });

  @override
  List<Object> get props => [
        notificationModel,
        onOpenApp,
      ];
}

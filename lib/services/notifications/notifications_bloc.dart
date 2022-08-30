// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dividends_tracker_app/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  NotificationsBloc()
      : super(const NotificationsInitialState(
          notificationModel: {},
        )) {
    on<OnMessageNotificationEvent>((event, emit) {
      // emit(NotificationsInitialState(
      //   notificationModel: NotificationModel.fromJson({
      //     "title": event.title,
      //     "body": event.body,
      //     "data": event.data,
      //   }),
      //   onOpenApp: event.onOpenApp,
      // ));
    });
  }

  void initialize() async {
    _notificationRepository.updateNotificationToken();

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   if (message.notification!.title != null &&
    //       message.notification!.body != null) {
    //     add(OnMessageNotificationEvent(
    //       title: message.notification!.title!,
    //       body: message.notification!.body!,
    //       data: message.data,
    //       onOpenApp: true,
    //     ));
    //   }
    // });

    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.notification!.title != null &&
    //       message.notification!.body != null) {
    //     add(OnMessageNotificationEvent(
    //       title: message.notification!.title!,
    //       body: message.notification!.body!,
    //       data: message.data,
    //     ));
    //   }
    // });
  }
}

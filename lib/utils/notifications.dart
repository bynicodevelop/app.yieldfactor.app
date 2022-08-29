import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void notification(
  BuildContext context,
  String title,
  String message,
  Color color,
) =>
    Flushbar(
      title: title,
      message: message,
      backgroundColor: color,
      duration: const Duration(
        seconds: 2,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(16.0),
      borderRadius: BorderRadius.circular(16.0),
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);

void sendErrorNotification(
  BuildContext context,
  String message, {
  String title = 'Error',
}) =>
    notification(
      context,
      title,
      message,
      Colors.red,
    );

void sendSuccessNotification(
  BuildContext context,
  String message, {
  String title = 'Success',
}) =>
    notification(
      context,
      title,
      message,
      Colors.green,
    );

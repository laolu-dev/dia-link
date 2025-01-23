import 'package:dialink/src/config/config.dart';
import 'package:dialink/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:talker_logger/talker_logger.dart';

extension ObjectOrNull on Object? {
  void printLog({Object? msg, LogLevel? level}) {
    switch (level) {
      case LogLevel.info:
        AppConstants.instance.logging.info(msg);
        break;

      case LogLevel.error:
        AppConstants.instance.logging.error(msg);
        break;

      case LogLevel.critical:
        AppConstants.instance.logging.critical(msg);
        break;

      default:
        AppConstants.instance.logging.debug(msg);
    }
  }
}

extension BuildContextExtension on BuildContext {
  Size get deviceSize => MediaQuery.sizeOf(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  NavigatorState get router => AppRouter.instance.routerKey.currentState!;
}

extension SizedBoxExtension on double {
  SizedBox get verticalSpacing => SizedBox(height: this);

  SizedBox get horizontalSpacing => SizedBox(width: this);
}

import 'package:flutter/material.dart';

import 'config/config.dart';

class Dialink extends StatelessWidget {
  const Dialink({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialink',
      theme: appTheme,
      navigatorKey: AppRouter.instance.routerKey,
      onGenerateRoute: (settings) => AppRouter.instance.routes(settings),
    );
  }
}

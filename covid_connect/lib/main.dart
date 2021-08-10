import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/data/local_storage.dart';
import 'package:covid_connect/data/network_service.dart';
import 'package:covid_connect/data/repository.dart';
import 'package:flutter/material.dart';

import 'package:covid_connect/presentation/app_router.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  final localStorage = LocalStorage(await SharedPreferences.getInstance());
  var initialRoute = welcomeRoute;

  if (localStorage.isUserLoggedIn()) {
    initialRoute = homeRoute;
  }

  runApp(CovidConnect(
      appRouter: AppRouter(
        Repository(
          NetworkService(),
          localStorage,
        ),
      ),
      initialRoute: initialRoute));
}

class CovidConnect extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;
  CovidConnect({
    Key? key,
    required this.appRouter,
    this.initialRoute = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}

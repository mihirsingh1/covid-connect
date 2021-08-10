import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/cubit/login_cubit.dart';
import 'package:covid_connect/cubit/signup_cubit.dart';
import 'package:covid_connect/data/network_service.dart';
import 'package:covid_connect/data/repository.dart';
import 'package:covid_connect/presentation/screens/home_screen.dart';
import 'package:covid_connect/presentation/screens/login_screen.dart';
import 'package:covid_connect/presentation/screens/welcome_screen.dart';
import 'package:covid_connect/presentation/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Repository repository;
  AppRouter(this.repository);

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(repository),
            child: LoginScreen(),
          ),
        );
      case signupRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(repository),
            child: SignupScreen(),
          ),
        );
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return null;
    }
  }
}

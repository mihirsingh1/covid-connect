import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/cubit/item_request_cubit.dart';
import 'package:covid_connect/cubit/login_cubit.dart';
import 'package:covid_connect/cubit/nav_cubit.dart';
import 'package:covid_connect/cubit/signup_cubit.dart';
import 'package:covid_connect/data/models/item_request_response.dart';
import 'package:covid_connect/data/network_service.dart';
import 'package:covid_connect/data/repository.dart';
import 'package:covid_connect/presentation/screens/home_screen.dart';
import 'package:covid_connect/presentation/screens/listing_screen.dart';
import 'package:covid_connect/presentation/screens/login_screen.dart';
import 'package:covid_connect/presentation/screens/new_request_screen.dart';
import 'package:covid_connect/presentation/screens/welcome_screen.dart';
import 'package:covid_connect/presentation/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Repository repository;
  late LoginCubit loginCubit;
  late ItemRequestCubit itemRequestCubit;

  AppRouter(this.repository) {
    loginCubit = LoginCubit(repository);
    itemRequestCubit = ItemRequestCubit(repository);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: loginCubit,
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
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<NavCubit>(create: (_) => NavCubit()),
              BlocProvider<LoginCubit>.value(value: loginCubit),
              BlocProvider<ItemRequestCubit>.value(value: itemRequestCubit)
            ],
            child: HomeScreen(),
          ),
        );
      case newRequestRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: itemRequestCubit,
            child: NewRequestScreen(),
          ),
        );
      case listingsRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: itemRequestCubit,
            child: ListingsScreen(),
          ),
        );
      default:
        return null;
    }
  }
}

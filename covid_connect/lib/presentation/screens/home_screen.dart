import 'package:covid_connect/cubit/item_request_cubit.dart';
import 'package:covid_connect/cubit/nav_cubit.dart';
import 'package:covid_connect/presentation/screens/feed_screen.dart';
import 'package:covid_connect/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: BottomBar(),
      ),
      body: BlocBuilder<NavCubit, PageChangedState>(
        builder: (context, state) {
          return state.page == 0 ? FeedScreen() : ProfileScreen();
        },
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemRequestCubit>(context).fetchItems();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        rippleColor: Colors.grey.shade800,
        hoverColor: Colors.grey.shade700,
        tabBorderRadius: 15,
        gap: 8,
        color: Colors.grey[800],
        activeColor: Colors.blue,
        iconSize: 24,
        tabBackgroundColor: Colors.blue.withOpacity(0.1),
        onTabChange: (i) {
          BlocProvider.of<NavCubit>(context).changePage(i);
        },
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        textStyle: GoogleFonts.sen(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          )
        ],
      ),
    );
  }
}

import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Text(
              BlocProvider.of<LoginCubit>(context).getUsername(),
              style: GoogleFonts.sen(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, newRequestRoute);
              },
              child: CustomTile(
                iconData: Icons.add,
                text: "New Request",
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, listingsRoute);
              },
              child: CustomTile(
                iconData: Icons.list,
                text: "Your Listings",
              ),
            ),
            Divider(),
            InkWell(
              onTap: () async {
                if (await BlocProvider.of<LoginCubit>(context).logout()) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, welcomeRoute, (route) => false);
                }
              },
              child: CustomTile(
                iconData: Icons.logout,
                text: "Logout",
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              iconData,
              size: 24.0,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 15.0),
          Text(
            text,
            style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

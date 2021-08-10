import 'package:covid_connect/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Background(),
              AppName(),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, loginRoute);
            },
            child: LoginButton(),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, signupRoute);
            },
            child: SignupButton(),
          )
        ],
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  const SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Center(
        child: Text(
          "Sign Up",
          style: GoogleFonts.quicksand(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35.0, right: 35.0, top: 40.0),
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Center(
        child: Text(
          "Login",
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}

class AppName extends StatelessWidget {
  const AppName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 40.0,
      left: 20.0,
      child: Text(
        appName,
        style: GoogleFonts.sen(
          color: Colors.grey[50],
          fontWeight: FontWeight.bold,
          fontSize: 32.0,
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.0),
        bottomLeft: Radius.circular(MediaQuery.of(context).size.width * 0.6),
      ),
      child: Stack(
        children: [
          Image.asset(
            backgroundImg,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.65,
            fit: BoxFit.cover,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            color: Color(0x4D000000),
          )
        ],
      ),
    );
  }
}

import 'package:covid_connect/constants/functions.dart';
import 'package:covid_connect/constants/strings.dart';
import 'package:covid_connect/cubit/login_cubit.dart';
import 'package:covid_connect/cubit/signup_cubit.dart';
import 'package:covid_connect/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Signup",
          style: GoogleFonts.sen(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupResult) {
            if (state.loginResponse.isSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeRoute, (route) => false);
            } else {
              showErrorToast("Couldn't log you in, check credentials");
            }
          }
        },
        child: SignupBody(
          usernameController: _usernameController,
          passwordController: _passwordController,
          confirmPassController: _confirmPassController,
        ),
      ),
    );
  }
}

class SignupBody extends StatelessWidget {
  const SignupBody({
    Key? key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
    required TextEditingController confirmPassController,
  })  : _usernameController = usernameController,
        _passwordController = passwordController,
        _confirmPassController = confirmPassController,
        super(key: key);

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPassController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
      child: Column(
        children: [
          SizedBox(height: 5.0),
          CustomTextField(
            "Username",
            _usernameController,
            autoFocus: true,
            inputType: TextInputType.text,
          ),
          SizedBox(height: 10.0),
          CustomTextField("Password", _passwordController,
              inputType: TextInputType.text),
          SizedBox(height: 10.0),
          CustomTextField("Confirm Password", _confirmPassController,
              inputType: TextInputType.text),
          InkWell(
            onTap: () {
              var username = _usernameController.text;
              var password = _passwordController.text;
              var confirmPass = _confirmPassController.text;

              if (username.trim() == "") {
                showErrorToast("Username cannot be empty");
                return;
              }
              if (password.trim() == "") {
                showErrorToast("Password cannot be empty");
                return;
              }
              if (password != confirmPass) {
                showErrorToast("Passwords don't match");
                return;
              }

              BlocProvider.of<SignupCubit>(context).signup(username, password);
            },
            child: Signup(),
          )
        ],
      ),
    );
  }
}

class Signup extends StatelessWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Center(
        child: Text(
          "Signup",
          style: GoogleFonts.quicksand(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}

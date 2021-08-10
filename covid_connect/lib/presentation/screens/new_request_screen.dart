import 'package:covid_connect/constants/functions.dart';
import 'package:covid_connect/cubit/item_request_cubit.dart';
import 'package:covid_connect/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class NewRequestScreen extends StatelessWidget {
  NewRequestScreen({Key? key}) : super(key: key);

  final itemController = TextEditingController();
  final descController = TextEditingController();
  final contactController = TextEditingController();
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "New Item Request",
          style: GoogleFonts.sen(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                "Item name",
                itemController,
                autoFocus: true,
              ),
              SizedBox(height: 10.0),
              CustomTextField("Description", descController),
              SizedBox(height: 10.0),
              CustomTextField(
                "Contact number",
                contactController,
                inputType: TextInputType.number,
              ),
              SizedBox(height: 10.0),
              CustomTextField("City name", cityController),
              SizedBox(height: 15.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45.0,
                child: MaterialButton(
                  onPressed: () {
                    final itemName = itemController.text;
                    final description = descController.text;
                    final contact = contactController.text;
                    final city = cityController.text;
                    if (itemName.isEmpty ||
                        description.isEmpty ||
                        contact.isEmpty ||
                        city.isEmpty) {
                      showErrorToast("One of the fields are missing");
                      return;
                    }

                    BlocProvider.of<ItemRequestCubit>(context)
                        .makeNewRequest(itemName, description, contact, city);

                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Submit Request",
                    style: GoogleFonts.sen(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

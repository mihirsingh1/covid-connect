import 'package:covid_connect/cubit/item_request_cubit.dart';
import 'package:covid_connect/data/models/covid_item.dart';
import 'package:covid_connect/presentation/widgets/listing_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ListingsScreen extends StatelessWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Your Listings",
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
        padding: const EdgeInsets.only(top: 15.0),
        child: BlocBuilder<ItemRequestCubit, DataUpdated>(
          builder: (context, state) {
            final covidItems =
                BlocProvider.of<ItemRequestCubit>(context).getUserItems();

            return ListView.builder(
              itemCount: covidItems.length,
              itemBuilder: (context, i) {
                final item = covidItems[i];

                return ListingItem(
                  item: item,
                  canDelete: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:covid_connect/cubit/item_request_cubit.dart';
import 'package:covid_connect/data/models/covid_item.dart';
import 'package:covid_connect/presentation/widgets/listing_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<CovidItem> feedItems = [];
  List<CovidItem> filteredList = [];

  bool isFiltered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 50.0, bottom: 10.0),
            child: buildTextField(),
          ),
          Expanded(
            child: buildFeedList(),
          ),
        ],
      ),
    );
  }

  Widget buildFeedList() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: BlocBuilder<ItemRequestCubit, DataUpdated>(
          builder: (context, state) {
            feedItems =
                BlocProvider.of<ItemRequestCubit>(context).getFeedItems();

            final listItems = !isFiltered ? feedItems : filteredList;

            return Column(
              children: listItems
                  .map(
                    (e) => ListingItem(
                      item: e,
                      canCall: true,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      onChanged: (v) {
        if (v == "") {
          isFiltered = false;
          filteredList = [];
        } else {
          isFiltered = true;
          filteredList = feedItems
              .where((element) =>
                  element.city.toLowerCase().startsWith(v.toLowerCase()))
              .toList();
        }

        setState(() {});
      },
      autofocus: false,
      style: TextStyle(fontSize: 13.0),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        filled: true,
        hintText: "Filter by city name",
        hintStyle: GoogleFonts.sen(color: Colors.grey, fontSize: 13.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

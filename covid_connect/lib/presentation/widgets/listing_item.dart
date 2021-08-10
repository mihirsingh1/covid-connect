import 'package:covid_connect/cubit/item_request_cubit.dart';
import 'package:covid_connect/data/models/covid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ListingItem extends StatelessWidget {
  const ListingItem({
    Key? key,
    required this.item,
    this.canDelete = false,
    this.canCall = false,
  }) : super(key: key);

  final CovidItem item;
  final bool canDelete;
  final bool canCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.itemName,
              style:
                  GoogleFonts.sen(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              item.desc,
              style: GoogleFonts.quicksand(color: Colors.grey.shade700),
              maxLines: 2,
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Text(
                  item.city,
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8.0),
                Text(
                  item.contact,
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                canDelete
                    ? InkWell(
                        onTap: () async {
                          if (await confirmDialog(context)) {
                            BlocProvider.of<ItemRequestCubit>(context)
                                .delete(item.id);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                    : Container(),
                canCall
                    ? InkWell(
                        onTap: () async {
                          await launch("tel://${item.contact}");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.call,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> confirmDialog(context) async {
    final isPositive = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Yes"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("No"),
            )
          ],
        );
      },
    );
    return isPositive;
  }
}

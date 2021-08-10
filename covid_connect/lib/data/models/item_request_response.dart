import 'package:covid_connect/data/models/covid_item.dart';

class ItemRequestReponse {
  final bool isSuccess;
  final String error;

  ItemRequestReponse(this.isSuccess, this.error);
}

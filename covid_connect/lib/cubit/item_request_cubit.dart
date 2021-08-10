import 'package:bloc/bloc.dart';
import 'package:covid_connect/constants/functions.dart';
import 'package:covid_connect/data/models/covid_item.dart';
import 'package:covid_connect/data/repository.dart';

part 'item_request_state.dart';

class ItemRequestCubit extends Cubit<DataUpdated> {
  final Repository repository;
  ItemRequestCubit(this.repository) : super(DataUpdated());

  void makeNewRequest(String itemName, String description, String contact,
      String cityName) async {
    String token = repository.localStorage.getToken();
    final itemRequestResult = await repository.makeItemRequest(
        itemName, description, contact, cityName, token);

    if (!itemRequestResult.isSuccess) {
      showErrorToast(itemRequestResult.error);
    }
  }

  void fetchItems() {
    final token = repository.localStorage.getToken();
    repository.fetchUserItems(token);
    repository.fetchAllItems().then((value) {
      emit(DataUpdated());
    });
  }

  List<CovidItem> getUserItems() {
    return repository.covidItems;
  }

  List<CovidItem> getFeedItems() {
    return repository.allItems;
  }

  void delete(String id) async {
    final token = repository.localStorage.getToken();
    repository.deleteItem(id, token).then((isDeleted) {
      if (!isDeleted) {
        showErrorToast("Something went wrong");
      } else {
        emit(DataUpdated());
      }
    });
  }
}

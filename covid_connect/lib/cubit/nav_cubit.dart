import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_state.dart';

class NavCubit extends Cubit<PageChangedState> {
  NavCubit() : super(PageChangedState(0));

  void changePage(int index) {
    emit(PageChangedState(index));
  }
}

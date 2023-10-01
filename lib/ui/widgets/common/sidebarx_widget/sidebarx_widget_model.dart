import 'package:stacked/stacked.dart';

class SidebarxWidgetModel extends BaseViewModel {
  bool isSidebarOpen = false;

 void updateValue() {
    isSidebarOpen = !isSidebarOpen;
    notifyListeners();
  }
}

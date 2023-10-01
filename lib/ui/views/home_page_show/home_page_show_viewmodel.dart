import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../aboutus/aboutus_view.dart';

class HomePageShowViewModel extends BaseViewModel {
  bool check = false;
  final navigationService = locator<NavigationService>();


  void updatevalue() {
    check = true;
    notifyListeners();
  }
}

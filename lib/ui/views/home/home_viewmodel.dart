import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../services/authentication_service.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final authservice = locator<AuthenticationService>();
   bool isExpanded = false;

  String currentPage = 'Home';
  final List homeicon = ['Home', 'History', 'About us', 'Contact us'];

  void navigationhistorypage() {
    navigationService.navigateToHistorypageView();
  }

  void setCurrentPage(String page) {
    currentPage = page;
    notifyListeners();
  }

  void expandstate() {
   isExpanded = !isExpanded;
    notifyListeners();
  }
}

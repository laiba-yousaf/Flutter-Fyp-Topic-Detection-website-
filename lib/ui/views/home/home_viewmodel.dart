import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/app/app.router.dart';


class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  

  String currentPage = 'Home';
  final List homeicon = ['Home', 'History', 'About us', 'Contact us'];

  void navigationhistorypage() {
    _navigationService.navigateToHistorypageView();
  }

  void setCurrentPage(String page) {
    currentPage = page;
    notifyListeners();
  }

}

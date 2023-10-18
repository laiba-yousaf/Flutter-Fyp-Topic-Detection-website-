import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';
import '../../../app/app.locator.dart';

class LandingPageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String name = "home";

  void navigateTOSignin() {
    _navigationService.navigateToSigninView();
  }

  void navigateSignup() {
    _navigationService.navigateToSignupView();
  }

  pagenavigate(String namepage) {
    name = namepage;
    notifyListeners();
  }
}

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';
import '../../../app/app.locator.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';

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

  tickMark() {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: kcPrimaryColor,
      ),
      child: Image(image: AssetImage(Tick)),
    );
  }
}

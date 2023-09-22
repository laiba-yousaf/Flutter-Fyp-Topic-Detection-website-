import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../services/authentication_service.dart';
import '../signin/signin_viewmodel.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  SigninViewModel viewModel1 = SigninViewModel();

  final authservice = locator<AuthenticationService>();

// Check if the user is logged in

  navigation() {
    _navigationService.navigateToSigninView();
  }

  navigationHome() {
    _navigationService.navigateToHomeView();
  }

  Future<void> isLogin() async {
    //final userid =await authservice.loadUserId();
    // Load the user ID from SharedPreferences
    print("user id from auth services are ${authservice.userId}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userid');

    if (authservice.userId != null) {
    } else {
      print("your user id not store in shared preference");
    }

    //final String? userid = prefs.getString('userId');

    print("________in startup model user id is $userId");
    if (userId != null) {
      Timer(const Duration(seconds: 3), () {
        navigationHome(); // User is logged in, navigate to the home view
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        navigation(); // User is not logged in, navigate to the sign-in view
      });
    }
  }
}

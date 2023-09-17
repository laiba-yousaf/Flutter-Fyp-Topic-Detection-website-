import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../app/app.locator.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  navigation() {
    _navigationService.navigateToSigninView();
  }

  navigationHome() {
    _navigationService.navigateToHomeView();
  }

  isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        navigationHome();
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        navigation();
      });
    }
  }
}

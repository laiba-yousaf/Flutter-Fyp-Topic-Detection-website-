import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';
import 'package:topicdetectionweb/services/authentication_service.dart';

import '../../../app/app.locator.dart';
import '../../../services/toastmessage_service.dart';

class SigninViewModel extends BaseViewModel {
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  final _navigationService = locator<NavigationService>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool obsecure = true;
  bool loading1 = false;
  final toastService = locator<ToastmessageService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final authservices = locator<AuthenticationService>();

  final bool isLoggedIn = true;

  navigation() {
    _navigationService.navigateToSignupView();
  }

  navigationHome() {
    _navigationService.navigateToHomeView();
  }

  void togglePasswordVisibility() {
    obsecure = !obsecure;
    notifyListeners();
  }

  setloading(bool value) {
    loading1 = value;
    notifyListeners();
  }

  login() {
    try {
      Future<User?> _user = authservices.login(emailctrl.text, passctrl.text);
      if (_user != null) {
        toastService.toastmessage("Login Successfully");
        navigationHome();
      } else {
        toastService.toastmessage("Login not Successfully");
      }
    } catch (e) {
      toastService.toastmessage(e.toString());
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../services/toastmessage_service.dart';

class SigninViewModel extends BaseViewModel {
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  final _navigationService = locator<NavigationService>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool obsecure = true;
  bool loading = false;
  final toastService = locator<ToastmessageService>();
final  GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
  setloadingvalue(bool value) {
    loading = value;
    notifyListeners();
  }
}

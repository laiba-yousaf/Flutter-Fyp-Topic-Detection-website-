import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../services/toastmessage_service.dart';

class SignupViewModel extends BaseViewModel {
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  TextEditingController conpassctrl = TextEditingController();

  bool obsecure = true;
  bool obsecure1 = true;
   final  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _navigationService = locator<NavigationService>();
  final toastService = locator<ToastmessageService>();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  void togglePasswordVisibility() {
    obsecure = !obsecure;
    notifyListeners();
  }

  void togglePasswordVisibility1() {
    obsecure1 = !obsecure1;
    notifyListeners();
  }

  void navigateTOSignin() {
    _navigationService.navigateToSigninView();
  }

  setloadingvalue(bool value) {
    loading = value;
    notifyListeners();
  }
}

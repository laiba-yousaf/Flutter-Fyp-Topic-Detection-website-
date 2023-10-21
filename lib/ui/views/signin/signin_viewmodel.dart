import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      clientId:
          '770365428478-m2f0b0nncj2ie71oa9bllruv8j0t8b37.apps.googleusercontent.com');

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

  login() async {
    try {
      User? _user = await authservices.login(emailctrl.text, passctrl.text);
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

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User user = authResult.user!;
        toastService.toastmessage("Login Succsessfully");
        navigationHome();
      }
    } catch (error) {
      toastService.toastmessage("Login failed $error");
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/views/signin/signin_viewmodel.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? userId;
  // Future<void> saveUserId(String userId) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userId', userId);
  // }

  // Load the user ID from SharedPreferences
  // Future<String?> loadUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final userid = prefs.getString('userId');
  //   print("----loding user id is--------$userid");
  //   return prefs.getString('userId');
  // }

  // Check if the user is logged in

  Future logout() async {
    try {
     SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      print("logout sucessfull");
    } catch (e) {
      // Handle logout error
      print("Logout error: $e");
    }
  }
  

  Future<User?> login(String email, String password) async {
    final UserCredential authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    userId = authResult.user!.uid;
    print("--------user id are--------$userId");

    // Save the user ID in SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', userId!);

    userId = prefs.getString('userid');
    print("---- user id after set id is--------$userId");

    return authResult.user;
  }
}

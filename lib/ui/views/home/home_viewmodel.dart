import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../services/authentication_service.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final authservice = locator<AuthenticationService>();
  
  final controller = SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState>key = GlobalKey<ScaffoldState>();

  String currentPage = 'Home';

 navigationSigninpage() {
    navigationService.navigateToSigninView();
  }

 
  

 
 
}

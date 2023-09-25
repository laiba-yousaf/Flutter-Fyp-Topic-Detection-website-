import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';

import '../../../app/app.locator.dart';

class HomePageShowViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  void navigateTouploadMeeting() {
    navigationService.navigateToUploadmeetingView();
  }
}

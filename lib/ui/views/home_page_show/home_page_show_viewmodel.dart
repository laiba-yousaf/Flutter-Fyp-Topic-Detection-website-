import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/speech_to_text_service.dart';
import '../aboutus/aboutus_view.dart';

class HomePageShowViewModel extends BaseViewModel {
  bool check = false;
  final navigationService = locator<NavigationService>();
   final speechtotextservice = locator<SpeechToTextService>();

  void updatevalue() {
    check = true;
    notifyListeners();
  }
}

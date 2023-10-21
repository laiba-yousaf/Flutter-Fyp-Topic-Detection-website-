import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/speech_to_text_service.dart';

class HomePageShowViewModel extends BaseViewModel {
  bool check = true;

  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final speechtotextservice = locator<SpeechToTextService>();

  void updatevalue() {
    check = !check;
    notifyListeners();
  }
}

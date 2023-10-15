import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.dialogs.dart';

import '../../../app/app.locator.dart';
import '../../../services/speech_to_text_service.dart';
import '../aboutus/aboutus_view.dart';

class HomePageShowViewModel extends BaseViewModel {
  bool check = false;
  final navigationService = locator<NavigationService>();
   final dialogService = locator<DialogService>();
   final speechtotextservice = locator<SpeechToTextService>();

  void updatevalue() {
    check = true;
    notifyListeners();
  }

   void showDialog() {
    dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked  stars on Github',
    );
  }

}

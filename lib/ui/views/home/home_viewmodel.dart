import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/app/app.router.dart';
import 'package:topicdetectionweb/services/authentication_service.dart';
import 'package:topicdetectionweb/services/speech_to_text_service.dart';
import 'package:topicdetectionweb/services/toastmessage_service.dart';

import '../../../services/firestoredata_service.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authservice = locator<AuthenticationService>();
  TextEditingController projectctrl = TextEditingController();
  final FirestoredataService firestoreService = FirestoredataService();
  TextEditingController descriptionctrl = TextEditingController();

  final controller = SidebarXController(selectedIndex: 0, extended: true);

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool loading = false;

  setloadingvalue(bool value) {
    loading = value;
    notifyListeners();
  }

  setPage(val, Map data) {
    controller.selectIndex(val);

    if (data.containsKey("title")) {
      projectctrl.text = data["title"];
    }

    if (data.containsKey("Description")) {
      descriptionctrl.text = data['Description'];
    }

    extractedList = data["mettinges"];

    firestoreService.eidtProjectId = data["id"];

    notifyListeners();
  }

  navigationLandingPage() {
    _navigationService.navigateToLandingPageView();
  }

  logout() async {
    await _authservice.logout();
    _navigationService.navigateToLandingPageView();
  }

  final speechtotextservice = locator<SpeechToTextService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final toastService = locator<ToastmessageService>();
  List<dynamic> extractedList = [];

  Future<void> uploadFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null && result.files.isNotEmpty) {
        final platformFile = result.files.first;
        final fileBytes = platformFile.bytes!;
        final fileName = platformFile.name;
        int sizeInBytes = fileBytes.lengthInBytes;
        double sizeInMb = sizeInBytes / (1024 * 1024);
        setBusy(true);
        extractedList.add(
          await speechtotextservice.uploadAudioFile(
            fileBytes,
            fileName,
            sizeInMb,
          ),
        );
        setBusy(false);
        notifyListeners();
      } else {
        setBusy(false);
        toastService.toastmessage("No .wav file selected.");
      }
    } catch (e) {
      setBusy(false);
      toastService.toastmessage(" $e");
    }
  }

  Future<void> saveDataToFirestore(Map<String, dynamic> uploadData) async {
    try {
      setloadingvalue(true);
      String result = await firestoreService.saveData(uploadData);
      toastService.toastmessage(result);
      setloadingvalue(false);
      projectctrl.clear();
      descriptionctrl.clear();
      extractedList = [];
    } catch (e) {
      setBusy(false);
      toastService.toastmessage(e.toString());
    }
  }

  onProceed() {
    Map<String, dynamic> uploadData = {
      "title": projectctrl.text,
      "mettinges": extractedList,
      "Description": descriptionctrl.text,
    };
    saveDataToFirestore(uploadData);
  }

  void deleteFile(int index) {
    if (index >= 0 && index < extractedList.length) {
      extractedList.removeAt(index);
    }
    notifyListeners();
  }

  setcreate(val) {
    controller.selectIndex(val);
    notifyListeners();
  }
}

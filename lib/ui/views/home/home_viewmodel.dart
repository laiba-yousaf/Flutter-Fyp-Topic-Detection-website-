import 'package:cloud_firestore/cloud_firestore.dart';
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

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authservice = locator<AuthenticationService>();
  TextEditingController projectctrl = TextEditingController();

  TextEditingController passctrl = TextEditingController();

  final controller = SidebarXController(selectedIndex: 0, extended: true);

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  String currentPage = 'Home';
  bool loading = false;

  setloadingvalue(bool value) {
    loading = value;
    notifyListeners();
  }

  setPage(val, Map data) {
    controller.selectIndex(val);
    projectctrl.text = data["title"];
    // passctrl.text = data["title"];
    extractedList = data["mettinges"];
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
        int sizeInBytes = result.files.length;
        double sizeInMb = sizeInBytes / (1024 * 1024);
        setBusy(true);
        extractedList.add(
          await speechtotextservice.uploadAudioFile(
              fileBytes, fileName, sizeInMb),
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
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      setloadingvalue(true);

      if (uploadData['mettinges'] != null &&
          uploadData['mettinges'].length > 0) {
        DocumentReference documentReference =
            firestore.collection('your_collection_name').doc();

        await documentReference.set({
          'title': uploadData['title'],
          'mettinges': uploadData['mettinges'],
          'timestamp': FieldValue.serverTimestamp(),
          'id': DateTime.now().millisecondsSinceEpoch.toString()
        });
        toastService.toastmessage("Data saved to Firestore successfully.");
        setloadingvalue(false);
      } else {
        toastService.toastmessage("You don't have any file for upload");
        setloadingvalue(false);
      }
    } catch (e) {
      setBusy(false);
      toastService.toastmessage("Error saving data to Firestore: $e");
    }
  }

  onProceed() {
    Map<String, dynamic> uploadData = {
      "title": projectctrl.text,
      "mettinges": extractedList
    };
    saveDataToFirestore(uploadData);
  }
}

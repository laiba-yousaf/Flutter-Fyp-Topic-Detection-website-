import 'dart:developer';

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
  final navigationService = locator<NavigationService>();
  final authservice = locator<AuthenticationService>();

  final controller = SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  String currentPage = 'Home';

  navigationLandingPage() {
    navigationService.navigateToLandingPageView();
  }

  final speechtotextservice = locator<SpeechToTextService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final toastService = locator<ToastmessageService>();
  List<dynamic> extractedList = [];
  Map selectedMeating = {};
  List<String> fileTypes = [
    ".acc",
    "flac",
    "mp4",
    "wav",
    "aiff",
    "mp3",
    "m4a",
    "flv",
    "mkv",
    "mov",
    "webm",
    "m4v",
    "mpeg",
    "mpg",
    "HEVC", /* Add other file types here */
  ];
  String? selectedFileType;

  void setSelectedFileType(String? fileType) {
    selectedFileType = fileType;
    notifyListeners();
  }

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
        notifyListeners();
      } else {
        setBusy(false);
        toastService.toastmessage("No .wav file selected.");
        log("No .wav file selected.");
      }
    } catch (e) {
      setBusy(false);
      toastService.toastmessage(" $e");
      print("Error: $e");
      // Handle the error as needed
    }
  }

  onProceed() {
    // Map uploadData = {"title": "title", "des": "title", "date": "title","mettinges":extractedList};
  }
}

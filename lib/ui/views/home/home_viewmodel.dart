import 'dart:developer';

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
  final navigationService = locator<NavigationService>();
  final authservice = locator<AuthenticationService>();
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

  navigationLandingPage() {
    navigationService.navigateToLandingPageView();
  }

  final speechtotextservice = locator<SpeechToTextService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final toastService = locator<ToastmessageService>();
  List<dynamic> extractedList = [];
  // Map selectedMeating = {};
  // List<String> fileTypes = [
  //   ".acc",
  //   "flac",
  //   "mp4",
  //   "wav",
  //   "aiff",
  //   "mp3",
  //   "m4a",
  //   "flv",
  //   "mkv",
  //   "mov",
  //   "webm",
  //   "m4v",
  //   "mpeg",
  //   "mpg",
  //   "HEVC", /* Add other file types here */
  // ];
  // String? selectedFileType;

  // void setSelectedFileType(String? fileType) {
  //   selectedFileType = fileType;
  //   notifyListeners();
  // }

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
        log("No .wav file selected.");
      }
    } catch (e) {
      setBusy(false);
      toastService.toastmessage(" $e");
      print("Error: $e");
      // Handle the error as needed
    }
  }

  Future<void> saveDataToFirestore(Map<String, dynamic> uploadData) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      setloadingvalue(true);
      // Get a Firestore DocumentReference with an auto-generated ID
       if (uploadData['mettinges'] != null && uploadData['mettinges'].length > 0){
      DocumentReference documentReference =
          firestore.collection('your_collection_name').doc();

      // Set the data with the server timestamp and the auto-generated document ID
     
        await documentReference.set({
        'title': uploadData['title'],
        'mettinges': uploadData['mettinges'],
        'timestamp': FieldValue.serverTimestamp(),
        'id': DateTime.now().millisecondsSinceEpoch.toString()
      });
      toastService.toastmessage("Data saved to Firestore successfully.");
       setloadingvalue(false);
      }
      else{
         toastService.toastmessage("You don't have any file for upload");
         setloadingvalue(false);
      }
    
      //print('Data saved to Firestore successfully.');
     
    } catch (e) {
      setBusy(false);
        toastService.toastmessage("Error saving data to Firestore: $e");
      //print('Error saving data to Firestore: $e');
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

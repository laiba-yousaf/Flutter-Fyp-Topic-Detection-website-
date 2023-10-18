import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/services/toastmessage_service.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/speech_to_text_service.dart';

class CreateProjectModel extends BaseViewModel {
  final speechtotextservice = locator<SpeechToTextService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final toastService = locator<ToastmessageService>();
  List<dynamic> ExtractedList = [];

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

  bool loading = false;

  setloadingvalue(bool value) {
    loading = value;
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
        setloadingvalue(true);
        final ExtractedList = await speechtotextservice.uploadAudioFile(
          fileBytes,
          fileName,
        );
        //print("filebytes ${ExtractedList[1]}");

        //print(extractedText);
      } else {
        setloadingvalue(false);
        toastService.toastmessage("No .wav file selected.");
        print("No .wav file selected.");
        // Handle the case where no file is selected
      }
    } catch (e) {
      setloadingvalue(false);
      toastService.toastmessage(" $e");
      print("Error: $e");
      // Handle the error as needed
    }
  }
}

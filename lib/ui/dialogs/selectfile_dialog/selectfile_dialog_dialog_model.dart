import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import '../../../services/firestoredata_service.dart';
import '../../../services/speech_to_text_service.dart';
import '../../../services/toastmessage_service.dart';

class SelectfileDialogDialogModel extends BaseViewModel {
  TextEditingController projectctrl = TextEditingController();
  final FirestoredataService firestoreService = FirestoredataService();
  TextEditingController descriptionctrl = TextEditingController();
  final toastService = locator<ToastmessageService>();
  final speechtotextservice = locator<SpeechToTextService>();
  List<dynamic> extractedList = [];
  final fileBytes;
  final fileName;
  final sizeInMb;
  SelectfileDialogDialogModel(
    this.fileBytes,
    this.fileName,
    this.sizeInMb,
    
  );

  bool loading = false;
  setloadingvalue(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> saveDataToFirestore(Map<String, dynamic> uploadData) async {
    try {
      setloadingvalue(true);
      String result = await firestoreService.saveData(uploadData);
      toastService.toastmessage(result);
      setloadingvalue(false);
      // projectctrl.clear();
      // descriptionctrl.clear();
      // extractedList = [];
    } catch (e) {
      setBusy(false);
      toastService.toastmessage(e.toString());
    }
  }

  Future<void> Uploadata(BuildContext context) async {
    try {
      if (fileBytes == null) {
        toastService.toastmessage(
            "No file has been picked. Please select a file first.");
        return; // Exit the function if no file has been picked
      }
      if (fileBytes != null && fileName != null && sizeInMb != null) {
        extractedList.add(
          await speechtotextservice.uploadAudioFile(
            fileBytes!,
            fileName!,
            sizeInMb!,
          ),
        );

        // Notify listeners to update the UI
        notifyListeners();

        // Construct the data to save to Firebase
        Map<String, dynamic> uploadData = {
          "title": projectctrl.text,
          "mettinges": extractedList,
          "Description": descriptionctrl.text,
        };

        // Save the data to Firebase
        await saveDataToFirestore(uploadData);

        // Show a success message
        toastService.toastmessage("File uploaded successfully.");
      } else {
        toastService.toastmessage("Failed to upload");
      }
    } catch (e) {
      toastService.toastmessage("Error$e");

    }
  }
}

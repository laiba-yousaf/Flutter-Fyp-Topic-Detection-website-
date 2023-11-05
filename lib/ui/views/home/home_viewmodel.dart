import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/app/app.router.dart';
import 'package:topicdetectionweb/services/authentication_service.dart';
import 'package:topicdetectionweb/services/toastmessage_service.dart';
import '../../../app/app.dialogs.dart';
import '../../../services/fetchdata_service.dart';
import '../../../services/firestoredata_service.dart';

final dialogService = locator<DialogService>();

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final _authservice = locator<AuthenticationService>();
  //final savedataService = locator<FirestoredataService>();
  TextEditingController projectctrl = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreService = locator<FirestoredataService>();
  TextEditingController descriptionctrl = TextEditingController();
  Uint8List? fileBytes;
  String? fileName;
  double? sizeInMb;
  String? eidtProjectId;
  final controller = SidebarXController(selectedIndex: 0, extended: true);

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool loading = false;
  String name = 'Edit Project';
  // int selectProjectindex = 0;

  // setProjectindex(value) {
  //   selectProjectindex = value;
  //   notifyListeners();
  // }

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
    eidtProjectId = data["id"];
    notifyListeners();
  }

  navigationLandingPage() {
    _navigationService.navigateToLandingPageView();
  }

  logout() async {
    await _authservice.logout();
    _navigationService.navigateToLandingPageView();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final toastService = locator<ToastmessageService>();
  final fetchdataservice = locator<FetchdataService>();
  List<dynamic> extractedList = [];

  Future<FilePickerResult?> pickAFile() async {
    FilePickerResult? pickedFileResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        '.acc',
        'flac',
        'mp4',
        'wav',
        'aiff',
        'mp3',
        'm4a',
        'flv',
        'mkv',
        'mov',
        'webm',
        'm4v',
        'mpeg',
        'mpg',
        'HEVC',
      ],
    );
    if (pickedFileResult != null && pickedFileResult.files.isNotEmpty) {
      final platformFile = pickedFileResult.files.first;
      fileBytes = platformFile.bytes;
      fileName = platformFile.name;
      final sizeInBytes = fileBytes!.lengthInBytes;
      sizeInMb = sizeInBytes / (1024 * 1024);
    }

    notifyListeners();
    return pickedFileResult;
  }

  onProceed() async {
    Map<String, dynamic> uploadData = {
      "title": projectctrl.text,
      "mettinges": extractedList,
      "Description": descriptionctrl.text,
    };

    try {
      String result = await firestoreService.saveData(uploadData,
          eidtProjectId: eidtProjectId);

      toastService.toastmessage(result);
      projectctrl.clear();
      descriptionctrl.clear();
      extractedList = [];
    } catch (e) {
      toastService.toastmessage(e.toString());
    }
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

  void showDialog(String filename, double size) {
    dialogService.showCustomDialog(
      variant: DialogType.selectfileDialog,
      title: filename,
      description: size.toStringAsFixed(2),
      data: {
        'fileBytes': fileBytes,
        'fileName': fileName,
        'sizeInMb': sizeInMb,
        'homemodel': HomeViewModel(),
        'extractedlist': extractedList,
        'Projectname': projectctrl.text,
        'onDataChanged': (data) {
          // Call the callback function to update data in HomeViewModel
          updateData(data);
        },
      },
    );
  }

  Future<void> filePick(BuildContext context) async {
    FilePickerResult? pickedFileResult = await pickAFile();

    try {
      if (pickedFileResult != null && pickedFileResult.files.isNotEmpty) {
        setBusy(true);
        showDialog(
          fileName!,
          sizeInMb!,
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

  void updateData(dynamic data) {
    extractedList = data;
    notifyListeners();
  }

  void displayDialog(String urdutext, String filename) {
    dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: filename,
      description: urdutext,
    );
  }

  void updatename(String updatename) {
    name = updatename;
    notifyListeners();
  }
}

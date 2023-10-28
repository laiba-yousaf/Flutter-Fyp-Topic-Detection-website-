
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.dialogs.dart';

import '../../../app/app.locator.dart';
import '../../../services/fetchdata_service.dart';
import '../../../services/toastmessage_service.dart';

class HistorypageViewModel extends BaseViewModel {
  int selectedProjectIndex = 0;
  int selectedFileIndex = 0;
  final toastService = locator<ToastmessageService>();
  final fetchdataservice = locator<FetchdataService>();
  final dialogService = locator<DialogService>();

  List<Map<String, dynamic>> firestoreData = [];

  Future<void> fetchDatafromfirestore() async {
    try {
      setBusy(true);
      firestoreData = await fetchdataservice.fetchDatafromfirestore();
    } catch (e) {
      toastService.toastmessage("Error fetching data from Firestore: $e");
    }
  }

  Future<void> fetchData() async {
    await fetchDatafromfirestore();
    notifyListeners();
  }

    void setindex(int index) {
      selectedProjectIndex = index;
      notifyListeners();
    }

    void setFileIndex(int index) {
      selectedFileIndex = index;
      notifyListeners();
    }

    void showDialog(String urdutext, String filename) {
      dialogService.showCustomDialog(
        variant: DialogType.infoAlert,
        title: filename,
        description: urdutext,
      );
    }
  }


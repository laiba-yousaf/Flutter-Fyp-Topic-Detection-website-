import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.dialogs.dart';

import '../../../app/app.locator.dart';
import '../../../services/toastmessage_service.dart';

class HistorypageViewModel extends BaseViewModel {
  int selectedProjectIndex = 0;
  int selectedFileIndex =0;
  final toastService = locator<ToastmessageService>();
  final dialogService = locator<DialogService>();
 
  // List data = [
  //   'Design data',
  //   'Error analysis',
  //   'Project management',
  //   'Technical Writing'
  // ];

  List<Map<String, dynamic>> firestoreData = [];

  Future<void> fetchDatafromfirestore() async {
    try {
      setBusy(true);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference =
          firestore.collection('your_collection_name');
      QuerySnapshot querySnapshot = await collectionReference.get();
      firestoreData = querySnapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return data;
      }).toList();
    } catch (e) {
      toastService.toastmessage("Error fetching data from Firestore: $e");
    }
  }

  Future<void> fetchData() async {
    await fetchDatafromfirestore();
    notifyListeners(); // Notify listeners after data is fetched
  }

  void setindex(int index) {
    selectedProjectIndex = index;
    notifyListeners();
  }

  void setFileIndex(int index) {
    selectedFileIndex  = index;
    notifyListeners();
  }

  void showDialog(String urdutext,String filename) {
    dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title:filename ,
      description: urdutext,
    );
  }
}

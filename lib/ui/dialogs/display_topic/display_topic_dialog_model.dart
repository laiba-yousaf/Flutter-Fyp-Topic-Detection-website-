import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayTopicDialogModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<List<String>>> getSummariesFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('summaries').get();

      List<List<String>> summaries = querySnapshot.docs
          .map((doc) => List<String>.from(doc['summary'] as List<dynamic>))
          .toList();
      return summaries;
    } catch (e) {
      print('Error fetching summaries from Firestore: $e');
      return [];
    }
  }
}

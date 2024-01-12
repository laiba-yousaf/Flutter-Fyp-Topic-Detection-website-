// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class DisplayTopicService {
//   Future<List<dynamic>> getSummaries(List<String> segments) async {
//     String apiUrl = 'http://127.0.0.1:5001/summarize';
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'segments': segments}),
//       );

//       if (response.statusCode == 200) {
//         // Parse the response JSON
//         final Map<String, dynamic> data = jsonDecode(response.body);

//         // Access the summaries
//         List<dynamic> summaries = data['summaries'];
//         print(summaries);
//         return summaries;
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       print('Error: $e');
//       return [];
//     }
//   }

// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayTopicService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> getSummaries(List<String> segments) async {
    String apiUrl = 'http://127.0.0.1:5001/summarize';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'segments': segments}),
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Access the summaries
        List<dynamic> summaries = data['summaries'];

        // Store the summaries in Firestore
        await _storeSummariesInFirestore(summaries);

        return summaries;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
  

  Future<void> _storeSummariesInFirestore(List<dynamic> summaries) async {
    try {
      CollectionReference summariesCollection =
          _firestore.collection('summaries');

      // Add each summary to Firestore
      for (dynamic summary in summaries) {
        await summariesCollection.add({'summary': summary});
      }
    } catch (e) {
      print('Error storing summaries in Firestore: $e');
    }
  }
}

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpeechToTextService {
  Future<List<dynamic>> uploadAudioFile(
      List<int> fileBytes, String fileName) async {
    String apiUrl = "http://202.142.147.3:5008/ClE_ASR";
    List<dynamic> uploadResult = [];
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Attach the audio file to the request
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType('audio', 'wav'),
      ),
    );

    // Send the request and wait for the response
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var lines = responseBody.split('\n');

      // Extract and concatenate Urdu text
      var urduText = '';
      for (var line in lines) {
        if (line.contains('spk')) {
          var parts = line.split(' ');
          if (parts.length >= 5) {
            urduText += parts.sublist(5).join(' ') + '\n';
          }
        }
      }
      uploadResult = [
        fileName,
        //fileBytes,
        urduText,
        FieldValue.serverTimestamp(), // Store the timestamp as a string
      ];

      // Print the extracted Urdu text
      print(urduText);

      //  print("filename is ${uploadResult[2]}");

      // Store the extracted Urdu text and file name in Firebase Firestore

      // final firestore = FirebaseFirestore.instance;
      // DocumentReference docRef =
      //     await firestore.collection('urduTextCollection').add({
      //   'fileName': fileName,
      //   'urduText': urduText,
      //   'timestamp': FieldValue.serverTimestamp(),
      // });

      // // Get the ID of the added document and store it in the Firestore document
      // String documentId = docRef.id;
      // await docRef.update({'id': documentId});

      // Write the extracted Urdu text to a file
      final blob = html.Blob([urduText]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'web'
        ..download = 'urdu_text.txt'
        ..click();

      html.Url.revokeObjectUrl(url);

      // You can return the extracted Urdu text or use it as needed
      //return urduText;
    } else {
      print("API call failed with status code: ${response.statusCode}");
      //return ''; // Handle the error as needed
    }
    return uploadResult;
  }

  // Future<String> uploadAudioFile(BuildContext context) async {
  //   String apiUrl = "http://202.142.147.3:5008/ClE_ASR";

  //   try {
  //     // Use FilePicker to select a .wav file
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.any,

  //       // FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       //   type: FileType.custom,
  //       //   allowedExtensions: ['wav'],
  //       //
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       // Get the selected file
  //       final platformFile = result.files.first;
  //       final fileBytes = platformFile.bytes!;
  //       final fileName = platformFile.name; // Get the file name

  //       // Create a multipart request
  //       var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  //       // Attach the audio file to the request
  //       request.files.add(
  //         http.MultipartFile.fromBytes(
  //           'file',
  //           fileBytes,
  //           filename: fileName, // Include the file name
  //           contentType: MediaType('audio', 'wav'),
  //         ),
  //       );

  //       // Send the request and wait for the response
  //       var response = await request.send();

  //       if (response.statusCode == 200) {
  //         // Read and decode the response from the server
  //         var responseBody = await response.stream.bytesToString();
  //         var lines = responseBody.split('\n');

  //         // Extract and concatenate Urdu text
  //         var urduText = '';
  //         for (var line in lines) {
  //           if (line.contains('spk')) {
  //             var parts = line.split(' ');
  //             if (parts.length >= 5) {
  //               urduText += parts.sublist(5).join(' ') + '\n';
  //             }
  //           }
  //         }

  //         // Print the extracted Urdu text
  //         print(urduText);

  //         // Store the extracted Urdu text and file name in Firebase Firestore
  //         final firestore = FirebaseFirestore.instance;
  //         DocumentReference docRef =
  //             await firestore.collection('urduTextCollection').add({
  //           'fileName': fileName,
  //           'urduText': urduText,
  //           'timestamp': FieldValue.serverTimestamp(),
  //         });

  //         // Get the ID of the added document and store it in the Firestore document
  //         String documentId = docRef.id;
  //         await docRef.update({'id': documentId});

  //         // Write the extracted Urdu text to a file
  //         final blob = html.Blob([urduText]);
  //         final url = html.Url.createObjectUrlFromBlob(blob);
  //         final anchor = html.AnchorElement(href: url)
  //           ..target = 'web'
  //           ..download = 'urdu_text.txt'
  //           ..click();

  //         html.Url.revokeObjectUrl(url);

  //         // You can return the extracted Urdu text or use it as needed
  //         return urduText;
  //       } else {
  //         print("API call failed with status code: ${response.statusCode}");
  //         return ''; // Handle the error as needed
  //       }
  //     } else {
  //       print("No .wav file selected.");
  //       return ''; // Handle the case where no file is selected
  //     }
  //   } catch (e) {
  //     print("Error sending request: $e");
  //     return ''; // Handle the error as needed
  //   }
  // }
}

// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart';

// class SpeechToTextService {
//   Future<String> uploadAudioFile(BuildContext context) async {
//     String apiUrl = "http://202.142.147.3:5008/ClE_ASR";

//     try {
//       // Use FilePicker to select a .wav file
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['wav'],
//       );

//       if (result != null && result.files.isNotEmpty) {
//         // Get the selected file
//         final platformFile = result.files.first;
//         final fileBytes = platformFile.bytes!;

//         // Create a multipart request
//         var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

//         // Attach the audio file to the request
//         request.files.add(
//           http.MultipartFile.fromBytes(
//             'file',
//             fileBytes,
//             filename: basename(platformFile.name),
//             contentType: MediaType('audio', 'wav'),
//           ),
//         );

//         // Send the request and wait for the response
//         var response = await request.send();

//         if (response.statusCode == 200) {
//           // Read and decode the response from the server
//           var responseBody = await response.stream.bytesToString();
//           var lines = responseBody.split('\n');

//           // Extract and concatenate Urdu text
//           var urduText = '';
//           for (var line in lines) {
//             if (line.contains('spk')) {
//               var parts = line.split(' ');
//               if (parts.length >= 5) {
//                 urduText += parts.sublist(5).join(' ') + '\n';
//               }
//             }
//           }

//           // Print the extracted Urdu text
//           print("\n$urduText");

//           // You can return the extracted Urdu text or use it as needed
//           return urduText;
//         } else {
//           print("API call failed with status code: ${response.statusCode}");
//           return ''; // Handle the error as needed
//         }
//       } else {
//         print("No .wav file selected.");
//         return ''; // Handle the case where no file is selected
//       }
//     } catch (e) {
//       print("Error sending request: $e");
//       return ''; // Handle the error as needed
//     }
//   }
// }

import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpeechToTextService {
  Future<String> uploadAudioFile(BuildContext context) async {
    String apiUrl = "http://202.142.147.3:5008/ClE_ASR";

    try {
      // Use FilePicker to select a .wav file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,

        // FilePickerResult? result = await FilePicker.platform.pickFiles(
        //   type: FileType.custom,
        //   allowedExtensions: ['wav'],
        //
      );

      if (result != null && result.files.isNotEmpty) {
        // Get the selected file
        final platformFile = result.files.first;
        final fileBytes = platformFile.bytes!;
        final fileName = platformFile.name; // Get the file name

        // Create a multipart request
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

        // Attach the audio file to the request
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            fileBytes,
            filename: fileName, // Include the file name
            contentType: MediaType('audio', 'wav'),
          ),
        );

        // Send the request and wait for the response
        var response = await request.send();

        if (response.statusCode == 200) {
          // Read and decode the response from the server
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

          // Print the extracted Urdu text
          print(urduText);

          // Store the extracted Urdu text and file name in Firebase Firestore
          final firestore = FirebaseFirestore.instance;
          DocumentReference docRef =
              await firestore.collection('urduTextCollection').add({
            'fileName': fileName,
            'urduText': urduText,
            'timestamp': FieldValue.serverTimestamp(),
          });

          // Get the ID of the added document and store it in the Firestore document
          String documentId = docRef.id;
          await docRef.update({'id': documentId});

          // Write the extracted Urdu text to a file
          final blob = html.Blob([urduText]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..target = 'web'
            ..download = 'urdu_text.txt'
            ..click();

          html.Url.revokeObjectUrl(url);

          // You can return the extracted Urdu text or use it as needed
          return urduText;
        } else {
          print("API call failed with status code: ${response.statusCode}");
          return ''; // Handle the error as needed
        }
      } else {
        print("No .wav file selected.");
        return ''; // Handle the case where no file is selected
      }
    } catch (e) {
      print("Error sending request: $e");
      return ''; // Handle the error as needed
    }
  }
}

// import 'dart:html' as html;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';

// class SpeechToTextService {
//   Future<String> uploadAudioFile(BuildContext context) async {
//     String convertApiUrl = "http://127.0.0.1:5000/convert";
//     String asrApiUrl = "http://202.142.147.3:5008/ClE_ASR";

//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.any,
//       );

//       if (result != null && result.files.isNotEmpty) {
//         final platformFile = result.files.first;
//         final fileBytes = platformFile.bytes!;
//         final fileName = platformFile.name;

//         // Send the .wav file to the first API to convert
//         var convertRequest = http.MultipartRequest('POST', Uri.parse(convertApiUrl));
//         convertRequest.files.add(
//           http.MultipartFile.fromBytes(
//             'file',
//             fileBytes,
//             filename: fileName,
//             contentType: MediaType('audio', 'wav'),
//           ),
//         );

//         var convertResponse = await convertRequest.send();

//         if (convertResponse.statusCode == 200) {
//           // Extract the response from the first API
//           var responseBody = await convertResponse.stream.bytesToString();
//           var responseJson = json.decode(responseBody);

//           // Get the converted URL from the response
//           String convertedUrl = responseJson['converted_url'];

//           // Create a new URL for the converted .wav file
//           Uri convertedFileUrl = Uri.parse("http://127.0.0.1:5000" + convertedUrl);

//           // Send the converted .wav file to the second API for text conversion
//           var asrRequest = http.MultipartRequest('POST', Uri.parse(asrApiUrl));
//           asrRequest.files.add(
//             http.MultipartFile.fromBytes(
//               'file',
//               await http.readBytes(convertedFileUrl),
//               filename: fileName,
//               contentType: MediaType('audio', 'wav'),
//             ),
//           );

//           var asrResponse = await asrRequest.send();

//           if (asrResponse.statusCode == 200) {
//             // Handle the ASR response
//             var asrResponseBody = await asrResponse.stream.bytesToString();

//             // Parse the ASR response and extract the Urdu text
//             var asrResponseData = json.decode(asrResponseBody);
//             String urduText = asrResponseData['message'];

//             // Print the extracted Urdu text
//             print(urduText);

//             // Store the extracted Urdu text and file name in Firebase Firestore
//             final firestore = FirebaseFirestore.instance;
//             DocumentReference docRef = await firestore.collection('urduTextCollection').add({
//               'fileName': fileName,
//               'urduText': urduText,
//               'timestamp': FieldValue.serverTimestamp(),
//             });

//             // Get the ID of the added document and store it in the Firestore document
//             String documentId = docRef.id;
//             await docRef.update({'id': documentId});

//             // Write the extracted Urdu text to a file
//             final blob = html.Blob([urduText]);
//             final url = html.Url.createObjectUrlFromBlob(blob);
//             final anchor = html.AnchorElement(href: url)
//               ..target = 'web'
//               ..download = 'urdu_text.txt'
//               ..click();

//             html.Url.revokeObjectUrl(url);

//             // You can return the extracted Urdu text or use it as needed
//             return urduText;
//           } else {
//             print("ASR API call failed with status code: ${asrResponse.statusCode}");
//             return ''; // Handle the error as needed
//           }
//         } else {
//           print("Convert API call failed with status code: ${convertResponse.statusCode}");
//           return ''; // Handle the error as needed
//         }
//       } else {
//         print("No .wav file selected.");
//         return ''; // Handle the case where no file is selected
//       }
//     } catch (e) {
//       print("Error sending request: $e");
//       return ''; // Handle the error as needed
//     }
//   }
// }

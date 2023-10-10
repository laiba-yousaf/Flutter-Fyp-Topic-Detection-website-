// import 'dart:io';
// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart';

// class SpeechToTextService {
//   Future<void> uploadAudioFile(BuildContext context) async {
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
//           // Read and print the response from the server
//           var responseBody = await response.stream.bytesToString();
//           print("API call successful! Response: $responseBody");
//         } else {
//           print("API call failed with status code: ${response.statusCode}");
//         }
//       } else {
//         print("No .wav file selected.");
//       }
//     } catch (e) {
//       print("Error sending request: $e");
//     }
//   }
// }

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class SpeechToTextService {
  Future<String> uploadAudioFile(BuildContext context) async {
    String apiUrl = "http://202.142.147.3:5008/ClE_ASR";

    try {
      // Use FilePicker to select a .wav file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['wav'],
      );

      if (result != null && result.files.isNotEmpty) {
        // Get the selected file
        final platformFile = result.files.first;
        final fileBytes = platformFile.bytes!;

        // Create a multipart request
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

        // Attach the audio file to the request
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            fileBytes,
            filename: basename(platformFile.name),
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
          print("\n$urduText");

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



// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;

// class SegmentapiService {
//   Future<List<String>> tokenizeTextFileFromUrl(String url) async {
//     // Replace with your API endpoint
//     String apiUrl = 'http://127.0.0.1:5000/api/tokenize';

//     try {
//       // Fetch the text file content using http.get
//       http.Response response = await http.get(Uri.parse(url));

//       // Check if the request was successful
//       if (response.statusCode == 200) {
//         Uint8List bytes = response.bodyBytes;

//         // Check if the content length is greater than 0
//         if (bytes.length > 0) {
//           // Create a MultipartRequest
//           var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

//           // Add the file to the MultipartRequest
//           request.files.add(
//             http.MultipartFile.fromBytes(
//               'file',
//               bytes,
//               filename: url.split('/').last,
//             ),
//           );

//           // Send the request and get the response
//           http.Response apiResponse = await http.Response.fromStream(await request.send());

//           // Check the response status
//           if (apiResponse.statusCode == 200) {
//             // Decode the response JSON
//             Map<String, dynamic> data = jsonDecode(apiResponse.body);

//             // Check if the 'segments' key exists in the response
//             if (data.containsKey('segments') && data['segments'] is List) {
//               List<String> segments = List<String>.from(data['segments']);
//               print('File content uploaded successfully. Segments: $segments');
//               return segments;
//             } else {
//               // Handle the case where 'segments' key is missing or not a List
//               print('Error: Invalid response format');
//             }
//           } else {
//             // Handle the case where the server returns an error status code
//             print('Error uploading file content. Status code: ${apiResponse.statusCode}');
//             print('Error response: ${apiResponse.body}');
//           }
//         } else {
//           print('Error: Empty file content');
//         }
//       } else {
//         // Handle the case where fetching file content from URL fails
//         print('Error fetching file content from URL. Status code: ${response.statusCode}');
//         throw Exception('Failed to fetch file content from URL');
//       }
//     } catch (e) {
//       // Handle any exception that might occur during the API request
//       print('Error making API request: $e');
//       throw Exception('Failed to make the API request');
//     }

//     // Return an empty list in case of errors
//     return [];
//   }
// }



//this is  updated code

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SegmentapiService {


  
Future<List<String>> tokenizeTextFileFromUrl(String url) async {
  String apiUrl = 'http://127.0.0.1:5000/api/tokenize';

  try {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;

      // Extract file extension from the file name in the URL
      String fileName = url.split('/').last;
      String fileExtension = fileName.split('.').last;

      // Pass the file extension to the server
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['fileExtension'] = fileExtension;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
          contentType: MediaType('application', 'octet-stream'), // Default content type
        ),
      );

      http.Response apiResponse = await http.Response.fromStream(await request.send());

      if (apiResponse.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(apiResponse.body);

        if (data.containsKey('segments') && data['segments'] is List) {
          List<String> segments = List<String>.from(data['segments']);
          print('File content uploaded successfully. Segments: $segments');
          return segments;
        } else {
          print('Error: Invalid response format');
        }
      } else {
        print('Error uploading file content. Status code: ${apiResponse.statusCode}');
        print('Error response: ${apiResponse.body}');
      }
    } else {
      print('Error fetching file content from URL. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch file content from URL');
    }
  } catch (e) {
    print('Error making API request: $e');
    throw Exception('Failed to make the API request');
  }

  return [];
}}






//TEXT api 

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class SegmentapiService {
//   Future<List<String>> tokenizeText(String text) async {
//     String apiUrl = 'http://127.0.0.1:5000/api/tokenize';
    

//     try {
//       print('Text length before API request: ${text.length}'); // Add this line for debugging
//       // Pass the text to the server
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: {'text': text},
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = jsonDecode(response.body);

//         if (data.containsKey('segments') && data['segments'] is List) {
//           List<String> segments = List<String>.from(data['segments']);
//           print('Text processed successfully. Segments: $segments');
//           return segments;
//         } else {
//           print('Error: Invalid response format');
//         }
//       } else {
//         print('Error processing text. Status code: ${response.statusCode}');
//         print('Error response: ${response.body}');
//       }
//     } catch (e) {
//       print('Error making API request: $e');
//       throw Exception('Failed to make the API request');
//     }

//     return [];
//   }
// }
















// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;

// class SegmentapiService {
//   Future<List<String>> tokenizeTextFileFromAssets(String url) async {
//     // Replace with your API endpoint
//     String apiUrl = 'http://127.0.0.1:5000/api/tokenize';

//     try {
      
//       String assetPath = url;

//       // Fetch the asset file content using http.get
//       http.Response response = await http.get(Uri.parse(assetPath));

//       // Check if the request was successful
//       if (response.statusCode == 200) {
//         Uint8List bytes = response.bodyBytes;

//         // Create a MultipartRequest
//         var formData = http.MultipartRequest('POST', Uri.parse(apiUrl));

//         // Add the file to the MultipartRequest
//         formData.files.add(http.MultipartFile.fromBytes(
//           'file',
//           bytes,
//           filename: assetPath.split('/').last,
//         ));

//         // Send the request
//         var apiResponse = await formData.send();

//         // Check the response status
//         if (apiResponse.statusCode == 200) {
//           print('File uploaded successfully');
//           var responseString = await apiResponse.stream.bytesToString();
//           print(responseString);
//           Map<String, dynamic> data = jsonDecode(responseString);
//           List<String> segments = List<String>.from(data['segments']);
//           return segments;
//           // Handle the response as needed
//         } else {
//           print('Error uploading file. Status code: ${apiResponse.statusCode}');
//           var errorString = await apiResponse.stream.bytesToString();
//           print(errorString);
//           // Handle the error
//         }
//       } else {
//         print('Error fetching asset file. Status code: ${response.statusCode}');
//         throw Exception('Failed to tokenize text file');
//         // Handle the error
//       }
//     } catch (e) {
//       print('Error making API request: $e');
//       throw Exception('Failed to make the API request');
//     }
//     return [];
//   }
// }














// try {
//   // Read the file as bytes from the assets
//   final ByteData data = await rootBundle.load(assetPath);
//   final Uint8List bytes = data.buffer.asUint8List();

//   // Convert bytes to base64
//   final String base64File = base64Encode(bytes);

//   var response = await http.post(
//     Uri.parse('http://127.0.0.1:5000/api/tokenize'),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'file_data': base64File}),
//   );

//   if (response.statusCode == 200) {
//     Map<String, dynamic> data = jsonDecode(response.body);
//     List<String> segments = List<String>.from(data['segments']);
//     return segments;
//   } else {
//     throw Exception('Failed to tokenize text file');
//   }
// } catch (e) {
//   print('Error making API request: $e');
//   throw Exception('Failed to make the API request');
// }

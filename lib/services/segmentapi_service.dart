
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SegmentapiService {
  Future tokenizeTextFileFromAssets() async {
    // Replace with your API endpoint
    String apiUrl = 'http://127.0.0.1:5000/api/tokenize';
   String apiUrl = 'http://127.0.0.1:5000/api/tokenize';

    var formData = http.MultipartRequest('POST', Uri.parse(apiUrl));

    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    await uploadInput.onChange.first;

    html.File file = uploadInput.files!.first;

    try {
      final List<int> bytes = await file.readAsBytes();

      formData.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: file.name,
      ));

      var response = await formData.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        print(await response.stream.bytesToString());
      } else {
        print('Error uploading file. Status code: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
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
  }
}

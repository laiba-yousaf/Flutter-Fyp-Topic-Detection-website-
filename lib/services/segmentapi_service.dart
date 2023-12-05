
import 'dart:io';

import 'package:http/http.dart' as http;

class SegmentapiService {
  Future tokenizeTextFileFromAssets() async {
    // Replace with your API endpoint
    String apiUrl = 'http://127.0.0.1:5000/api/tokenize';

    // Replace with the path of the file you want to upload
    File file = File("assets/MR001_input.txt");

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add file to the request
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.lengthSync(); // Use lengthSync instead of length
    var multipartFile = http.MultipartFile('file', fileStream, length,
        filename: file.path.split('/').last);

    // Add form data if needed
    request.fields['key'] = 'value';

    // Add the file to the request
    request.files.add(multipartFile);

    // Send the request
    var response = await request.send();

    // Check the status code of the response
    if (response.statusCode == 200) {
      print('File uploaded successfully');
      var res = await response.stream.bytesToString();
      // Print the response body
      print(res.toString());
    } else {
      print('Error uploading file. Status code: ${response.statusCode}');
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

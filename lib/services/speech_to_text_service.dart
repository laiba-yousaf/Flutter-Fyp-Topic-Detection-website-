// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SpeechToTextService {
  Future<Map> uploadAudioFile(
      List<int> fileBytes, String fileName, double size) async {
    String apiUrl = "http://202.142.147.3:5008/ClE_ASR";
    Map uploadResult = {};

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType('audio', 'wav'),
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var lines = responseBody.split('\n');

      var urduText = '';
      for (var line in lines) {
        if (line.contains('spk')) {
          var parts = line.split(' ');
          if (parts.length >= 5) {
            urduText += '${parts.sublist(5).join(' ')}\n';
          }
        }
      }
      uploadResult = {
        "fileName": fileName,
        "size": size,
        "urduText": urduText,
      };

      final blob = html.Blob([urduText]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'web'
        ..download = 'urdu_text.txt'
        ..click();

      html.Url.revokeObjectUrl(url);
    } else {
      print("API call failed with status code: ${response.statusCode}");
    }
    return uploadResult;
  }
}

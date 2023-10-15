import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/services/speech_to_text_service.dart';

class InfoAlertDialogModel extends BaseViewModel {
  final speechtotextservice = locator<SpeechToTextService>();
}

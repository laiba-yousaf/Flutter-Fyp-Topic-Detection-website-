import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/app/app.locator.dart';
import 'package:topicdetectionweb/services/speech_to_text_service.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';

class InfoAlertDialogModel extends BaseViewModel {
  final speechtotextservice = locator<SpeechToTextService>();

  void showFirstDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: SizedBox(
                width: 300, // Set a specific width
                height: 350,
                child: ListView(children: const [
                  ListTile(
                    leading: Text("25Mb"),
                    title: Text("Meeting 1"),
                    trailing: Text("02-10-2023"),
                    tileColor: Color.fromARGB(255, 244, 231, 245),
                  ),
                  verticalSpaceSmall,
                  ListTile(
                    leading: Text("25Mb"),
                    title: Text("Meeting 2"),
                    trailing: Text("02-10-2023"),
                    tileColor: Color.fromARGB(255, 244, 231, 245),
                  ),
                  verticalSpaceSmall,
                  ListTile(
                    leading: Text("25Mb"),
                    title: Text("Meeting 3"),
                    trailing: Text("02-10-2023"),
                    tileColor: Color.fromARGB(255, 244, 231, 245),
                  ),
                ]),
              ),
            ),
            horizontalSpacemassiveLarge,
            SizedBox(
              height: 350,
              width: 400,
              child: Card(
                  color: Color.fromARGB(255, 244, 231, 245),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        5.0), // Circle radius as per your requirement
                  ),
                  child: Column(children: [
                    verticalSpaceMedium,
                    ClipOval(
                      child: Image(
                        image: AssetImage(filepic),
                        width: 130,
                        height: 130,
                      ),
                    ),
                    verticalSpaceLarge,
                    Button(
                      textColor: kcVeryLightGrey,
                      Color: kcPrimaryColor,
                      height: screenHeight(context) * 0.06,
                      width: quarterScreenWidth(context) * 0.5,
                      title: "Upload  Meeting",
                      onTap: () async {
                        try {
                          //await speechtotextservice.uploadAudioFile(context);
                        } catch (e) {
                          print("Error uploading audio file: $e");
                          // Handle the error as needed, e.g., show an error message to the user
                        }
                        //viewModel.updatevalue();
                        //viewModel.navigateTouploadMeeting();
                      },
                    ),
                  ])),
            )
          ]),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

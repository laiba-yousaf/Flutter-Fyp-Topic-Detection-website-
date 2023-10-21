import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/landing_page/widgets/feature.dart';

Widget feature() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpaceLarge,
      const Text(
        "Features",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: kcpurpleColor,
        ),
      ),
      verticalSpaceMedium,
      Text(halfFeatureHeading),
      verticalSpaceSmall,
      Text(fullFeatureHeading),
      verticalSpaceMedium,
      Row(
        children: [
          featurecard(feature1, "Seamless Audio Upload",
              "Our platform offers a user-friendly\nexperience where you can effortlessly\nupload your audio files."),
          horizontalSpaceMedium,
          featurecard(video, "Seamless Video Upload",
              "Discover our platform's seamless experience for effortlessly uploading\nyour video files."),
          horizontalSpaceMedium,
          featurecard(feature3, "Clear Topic Visualization",
              "Once your audio is processed, our\n website presents the extracted topics\nin a clear and organized manner\nmaking it easy for you to grasp the key\ndiscussion points."),
          horizontalSpaceMedium,
          featurecard(feature4, "Effortless Export to Excel",
              "\tTake control of your data with the option\n to export the extracted topics directly\n to an Excel (.xls) file This feature simplifies your workflow and allows for\n convenient data management."),
        ],
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import '../../../common/app_strings.dart';
import '../landing_page_viewmodel.dart';
import 'Feature card.dart';

class FeatureDescription extends ViewModelWidget<LandingPageViewModel> {
  const FeatureDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    LandingPageViewModel viewModel,
  ) {
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
            Featurecard(
                img: feature1,
                title: "Seamless Audio Upload",
                dec:
                    "Our platform offers a user-friendly\nexperience where you can effortlessly\nupload your audio files."),
            horizontalSpaceMedium,
            Featurecard(
                img: video,
                title: "Seamless Video Upload",
                dec:
                    "Discover our platform's seamless experience for effortlessly uploading\nyour video files."),
            horizontalSpaceMedium,
            Featurecard(
                img: feature3,
                title: "Clear Topic Visualization",
                dec:
                    "Once your audio is processed, our\n website presents the extracted topics\nin a clear and organized manner\nmaking it easy for you to grasp the key\ndiscussion points."),
            horizontalSpaceMedium,
            Featurecard(
                img: feature4,
                title: "Effortless Export to Excel",
                dec:
                    "\tTake control of your data with the option\n to export the extracted topics directly\n to an Excel (.xls) file This feature simplifies your workflow and allows for\n convenient data management."),
          ],
        )
      ],
    );
  }
}

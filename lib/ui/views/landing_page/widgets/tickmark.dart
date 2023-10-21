import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';

Widget tickMark() {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: kcPrimaryColor,
    ),
    child: Image(image: AssetImage(Tick)),
  );
}

Widget benifit(String title1, String title2, String title3, String title4) {
  return Column(
    children: [
      Row(
        children: [
          tickMark(),
          horizontalSpaceSmall,
          Text(title1),
          horizontalSpaceLarge,
          tickMark(),
          horizontalSpaceSmall,
          Text(title2),
        ],
      ),
      verticalSpaceLarge,
      Row(
        children: [
          horizontalSpaceTiny,
          horizontalSpaceTiny,
          tickMark(),
          horizontalSpaceSmall,
          Text(title3),
          horizontalSpaceSmall,
          horizontalSpaceTiny,
          tickMark(),
          horizontalSpaceSmall,
          Text(title4),
        ],
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';

Widget featurecard(String img, String title, String dec) {
  return SizedBox(
    height: 230,
    width: 200,
    child: Card(
      elevation: 10,
      color: kcfeatureColor,
      child: Column(
        children: [
          verticalSpaceSmall,
          Image(
            image: AssetImage(img),
            width: 100,
            height: 100,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              dec,
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    ),
  );
}

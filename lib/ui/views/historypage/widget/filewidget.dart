import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';

Widget filedata(
  String number,
  String projectName,
  String date,
) {
  return Row(children: [
    Text(number),
    horizontalSpaceLarge,
    Text(projectName),
    Padding(
      padding: const EdgeInsets.only(left: 75),
      child: Text(
        date,
      ),
    ),
  ]);
}

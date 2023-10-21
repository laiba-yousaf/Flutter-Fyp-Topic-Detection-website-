import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'historypage_viewmodel.dart';

class ProjectCardHistory extends ViewModelWidget<HistorypageViewModel> {
  final Map projectData;
  final int index;
  const ProjectCardHistory({
    Key? key,
    required this.projectData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    HistorypageViewModel viewModel,
  ) {
    return GestureDetector(
      onTap: () {
        viewModel.setindex(index);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 100),
        child: Container(
          decoration: BoxDecoration(
              color: viewModel.selectedProjectIndex == index
                  ? kcsliderColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text("${index + 1}"),
              horizontalSpaceLarge,
              Text(projectData['title']),
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: Text(
                  (projectData['timestamp'] as Timestamp).toDate().toString(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

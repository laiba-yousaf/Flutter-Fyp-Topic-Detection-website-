import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import '../home/home_viewmodel.dart';
import 'historypage_viewmodel.dart';

class ProjectCardHistory extends ViewModelWidget<HistorypageViewModel> {
  final HomeViewModel homeViewModel;
  final Map projectData;
  final int index;
  const ProjectCardHistory(
      {Key? key,
      required this.projectData,
      required this.index,
      required this.homeViewModel})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
    HistorypageViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text("${index + 1}"),
        ),
        horizontalSpaceLarge,
        Padding(
          padding: const EdgeInsets.only(left: 150),
          child: Text(projectData['title']),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 150),
          child: Text(
            (projectData['timestamp'] as Timestamp).toDate().toString(),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 120),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      homeViewModel.setPage(3, viewModel.firestoreData[index]);
                       homeViewModel.setProjectindex(index);

                    },
                    child: const Icon(Icons.edit_document)),
              ],
            )),
      ]),
    );
  }
}

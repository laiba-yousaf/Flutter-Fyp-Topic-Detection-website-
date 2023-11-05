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
  const ProjectCardHistory({
    Key? key,
    required this.projectData,
    required this.index,
    required this.homeViewModel,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    HistorypageViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: SizedBox(
              height: 30,
              width: 50,
              child: Text("${index + 1}"),
            ),
          ),
          horizontalSpaceLarge,
          Padding(
            padding: const EdgeInsets.only(left: 120),
            child: SizedBox(
              height: 30,
              width: 100,
              child: Text(projectData['title']),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 180),
            child: SizedBox(
              height: 40,
              width: 190,
              child: Text(
                (projectData['timestamp'] as Timestamp).toDate().toString(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120),
            child: SizedBox(
              height: 50,
              width: 100,
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: 'editProject',
                    child: Row(
                      children: [
                        Icon(Icons.edit_document),
                        SizedBox(width: 8),
                        Text('Edit Project'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'editFile',
                    child: Row(
                      children: [
                        Icon(Icons.edit_attributes),
                        SizedBox(width: 8),
                        Text('Edit File'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'editProject') {
                    homeViewModel.setPage(5, projectData);
                  } else if (value == 'editFile') {
                    homeViewModel.updatename("Edit Project");
                    homeViewModel.setPage(6, projectData);
                  } else if (value == 'delete') {
                    viewModel.deleteProjectDialog(projectData['id']);
                    // print("after delete fuction");
                    // viewModel.fetchData();
                    // print("Fetchdata fuction");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

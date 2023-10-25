import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/historypage/historypage_viewmodel.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';

class ProjectDetails extends ViewModelWidget<HistorypageViewModel> {
  final HomeViewModel homeViewModel;

  const ProjectDetails({Key? key, required this.homeViewModel})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
    HistorypageViewModel viewModel,
  ) {
    return SizedBox(
      height: 360,
      width: thirdScreenWidth(context) * 1.2,
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                children: [
                  const Text(
                    "Project Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Spacer(),
                  Button(
                      title: "Edit",
                      height: screenHeight(context) * 0.04,
                      width: quarterScreenWidth(context) * 0.2,
                      Color: kcsliderColor,
                      textColor: kcVeryLightGrey,
                      onTap: () {
                        homeViewModel.setPage(
                            3,
                            viewModel
                                .firestoreData[viewModel.selectedProjectIndex]);
                      }),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "No",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //horizontalSpaceLarge,
                  Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Text(
                      "FileName",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Text(
                      "Size",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            viewModel.selectedProjectIndex >= 0 &&
                    viewModel.selectedProjectIndex <
                        viewModel.firestoreData.length
                ? SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: viewModel
                            .firestoreData[viewModel.selectedProjectIndex]
                                ['mettinges']
                            .length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final meetings = viewModel
                                  .firestoreData[viewModel.selectedProjectIndex]
                              ['mettinges'][index];

                          return GestureDetector(
                            onTap: () {
                              viewModel.setFileIndex(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: viewModel.selectedFileIndex == index
                                      ? kcsliderColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text((index + 1).toString()),
                                    const Text(":"),
                                    horizontalSpaceLarge,
                                    Text(meetings["fileName"]),
                                    horizontalSpaceLarge,
                                    Text(meetings["size"].toStringAsFixed(2) +
                                        " Mb"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                :  SizedBox(
                    height: screenHeight(context)*0.2,
                    child: const Center(child: Text("no data available")),
                  ),
            const Divider(),
            SizedBox(
              height: screenHeight(context)*0.06,                      
              child: Padding(
                padding: const EdgeInsets.only(left: 230, bottom: 5),
                child: Row(
                  children: [
                    Button(
                        title: "Topic Detected",
                        height: screenHeight(context) * 0.05,
                        width: quarterScreenWidth(context) * 0.4,
                        Color: kcsliderColor,
                        textColor: kcDarkGreyColor,
                        onTap: () {}),
                    horizontalSpaceSmall,
                    Button(
                        title: "Urdu Transcript",
                        height: screenHeight(context) * 0.05,
                        width: quarterScreenWidth(context) * 0.4,
                        Color: kcsliderColor,
                        textColor: kcDarkGreyColor,
                        onTap: () {
                          final meetings = viewModel
                                  .firestoreData[viewModel.selectedProjectIndex]
                              ['mettinges'][viewModel.selectedFileIndex];
            
                          viewModel.showDialog(
                              meetings['urduText'], meetings['fileName']);
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

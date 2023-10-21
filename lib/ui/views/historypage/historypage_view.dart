import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/historypage/widget/filewidget.dart';
import 'package:topicdetectionweb/ui/views/historypage/widget/ProjectDetails.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';

import 'historypage_viewmodel.dart';

class HistorypageView extends StackedView<HistorypageViewModel> {
  const HistorypageView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(HistorypageViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.fetchData();
  }

  @override
  Widget builder(
    BuildContext context,
    HistorypageViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(40.0),
          child: SizedBox(
            height: screenHeight(context),
            width: screenWidth(context) * 0.82,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 450),
                          child: Text(
                            "History",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Button(
                            title: "Edit",
                            height: screenHeight(context) * 0.04,
                            width: quarterScreenWidth(context) * 0.3,
                            Color: kcsliderColor,
                            textColor: kcDarkGreyColor,
                            onTap: () {}),
                      ],
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "No",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  horizontalSpaceLarge,
                                  Text(
                                    "ProjectName",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 90),
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpaceMedium,
                              ListView.builder(
                                itemCount: viewModel.firestoreData.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = viewModel.firestoreData[index];
                                  print(data);
                                  final number = index + 1;
                                  final projectName = data['title'];

                                  final timestamp = data['timestamp'];
                                  final date =
                                      (timestamp as Timestamp).toDate();

                                  return GestureDetector(
                                    onTap: () {
                                      viewModel.setindex(index);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: viewModel
                                                        .selectedProjectIndex ==
                                                    index
                                                ? kcsliderColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: filedata(number.toString(),
                                              projectName, date.toString()),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        )),
                        const Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.only(top: 25, right: 20),
                              child: ProjectDetails()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  HistorypageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HistorypageViewModel();
}

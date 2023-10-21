import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/historypage/filewidget.dart';
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
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,

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
                            onTap: () {

                            }),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(top: 30),
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
                                  final number =
                                      index + 1; // Auto-incremented number
                                  final projectName = data['title'];
                                  // Replace with the actual field name
                                  final timestamp = data['timestamp'];
                                  final date =
                                      (timestamp as Timestamp).toDate();
                                  // Replace with the actual field name

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
                        //Spacer(),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25, right: 20),
                            child: SizedBox(
                              height: 360,
                              width: thirdScreenWidth(context) * 1.2,
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 10),
                                      child: Text(
                                        "Projects Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Divider(),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "No",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          horizontalSpaceLarge,
                                          Text(
                                            "FileName",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 90),
                                            child: Text(
                                              "Size",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    viewModel.selectedProjectIndex >= 0 &&
                                            viewModel.selectedProjectIndex <
                                                viewModel.firestoreData.length
                                        ? ListView.builder(
                                            itemCount: viewModel
                                                .firestoreData[viewModel
                                                        .selectedProjectIndex]
                                                    ['mettinges']
                                                .length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final meetings = viewModel
                                                          .firestoreData[
                                                      viewModel
                                                          .selectedProjectIndex]
                                                  ['mettinges'][index];

                                              return GestureDetector(
                                                onTap: () {
                                                  viewModel.setFileIndex(index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: viewModel
                                                                  .selectedFileIndex ==
                                                              index
                                                          ? kcsliderColor
                                                          : Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text((index + 1)
                                                            .toString()),
                                                        Text(":"),
                                                        horizontalSpaceLarge,
                                                        Text(meetings[
                                                            "fileName"]),
                                                        horizontalSpaceLarge,
                                                        Text(meetings["size"]
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        : Text("no data available"),
                                    verticalSpaceLarge,
                                    Divider(),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 200, bottom: 10, top: 10),
                                      child: Row(
                                        children: [
                                          Button(
                                              title: "Topic Detected",
                                              //loading: viewModel.loading,
                                              height:
                                                  screenHeight(context) * 0.05,
                                              width:
                                                  quarterScreenWidth(context) *
                                                      0.4,
                                              Color: kcsliderColor,
                                              textColor: kcDarkGreyColor,
                                              onTap: () {
                                                //viewModel.onProceed();
                                              }),
                                          horizontalSpaceSmall,
                                          Button(
                                              title: "Urdu Transcript",
                                              //loading: viewModel.loading,
                                              height:
                                                  screenHeight(context) * 0.05,
                                              width:
                                                  quarterScreenWidth(context) *
                                                      0.4,
                                              Color: kcsliderColor,
                                              textColor: kcDarkGreyColor,
                                              onTap: () {
                                                final meetings = viewModel
                                                                .firestoreData[
                                                            viewModel
                                                                .selectedProjectIndex]
                                                        ['mettinges'][
                                                    viewModel
                                                        .selectedFileIndex];

                                                //viewModel.onProceed();
                                                viewModel.showDialog(
                                                    meetings['urduText'],
                                                    meetings['fileName']);
                                              }),
                                        ],
                                      ),
                                    )
                                    //Spacer(),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 400, bottom: 20),
                                    //   child: Button(
                                    //     textColor: kcVeryLightGrey,
                                    //     Color: kcPrimaryColor,
                                    //     height: screenHeight(context) * 0.06,
                                    //     width:
                                    //         quarterScreenWidth(context) * 0.5,
                                    //     title: "Export",
                                    //     onTap: () {},
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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

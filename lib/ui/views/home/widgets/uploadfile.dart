import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import '../../../common/app_colors.dart';

class Uploadfile extends ViewModelWidget<HomeViewModel> {
  final String projectname;
  const Uploadfile({super.key, required this.projectname});

  @override
  Widget build(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 230, top: 70),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: 100,
            child: Text(
              projectname,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          verticalSpaceMedium,
          SizedBox(
            height: 400,
            width: thirdScreenWidth(context) * 1.7,
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 70),
                          child: Text(
                            "Project Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(children: [
                            Button(
                              textColor: kcVeryLightGrey,
                              title: "Select File",
                              loading: viewModel.isBusy,
                              height: screenHeight(context) * 0.04,
                              Color: kcsliderColor,
                              width: quarterScreenWidth(context) * 0.3,
                              onTap: () {
                                viewModel.filePick(context);
                              },
                            ),
                            horizontalSpaceSmall,
                            Button(
                              textColor: kcVeryLightGrey,
                              title: "Save",
                              loading: viewModel.loading,
                              height: screenHeight(context) * 0.04,
                              Color: kcsliderColor,
                              width: quarterScreenWidth(context) * 0.4,
                              onTap: () async {
                                viewModel.setloadingvalue(true);
                                //viewModel.fetchData();
                                await viewModel.onProceed();
                                viewModel.setloadingvalue(false);
                                viewModel.setcreate(7);
                              },
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 80),
                          child: Text(
                            "No",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        //horizontalSpaceLarge,
                        Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Text(
                            "FileName",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Text(
                            "Size",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Text(
                            "Actions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceMedium,
                  viewModel.extractedList.isNotEmpty
                      ? ListView.builder(
                          itemCount: viewModel.extractedList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120),
                                    child: SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Text(viewModel.extractedList[index]
                                          ["fileName"]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 110),
                                    child: SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Text(viewModel.extractedList[index]
                                                  ["size"]
                                              .toStringAsFixed(2) +
                                          " Mb"),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 65),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.deleteFile(index);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: kcPrimaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          horizontalSpaceSmall,
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Tooltip(
                                                message: "Display Topics",
                                                child: Icon(Icons.view_array)),
                                          ),
                                          horizontalSpaceSmall,
                                          GestureDetector(
                                              onTap: () {
                                                viewModel.displayDialog(
                                                    viewModel.extractedList[
                                                        index]["urduText"],
                                                    viewModel.extractedList[
                                                        index]["fileName"]);
                                              },
                                              child: const Tooltip(
                                                message: "Display Urdu Text",
                                                child: Icon(
                                                    Icons.display_settings),
                                              ))
                                        ],
                                      )),
                                ],
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          height: thirdScreenWidth(context) * 0.4,
                          child: const Center(
                            child: Text(
                              "No File Uploaded So Far",
                              style: TextStyle(
                                color: kcLightGrey,
                              ),
                            ),
                          ),
                        ),

                  // const Divider(),
                  // SizedBox(
                  //   height: screenHeight(context) * 0.06,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 230, bottom: 5),
                  //     child: Row(
                  //       children: [
                  //         Button(
                  //             title: "Topic Detected",
                  //             height: screenHeight(context) * 0.05,
                  //             width: quarterScreenWidth(context) * 0.4,
                  //             Color: kcsliderColor,
                  //             textColor: kcDarkGreyColor,
                  //             onTap: () {}),
                  //         horizontalSpaceSmall,
                  //         Button(
                  //             title: "Urdu Transcript",
                  //             height: screenHeight(context) * 0.05,
                  //             width: quarterScreenWidth(context) * 0.4,
                  //             Color: kcsliderColor,
                  //             textColor: kcDarkGreyColor,
                  //             onTap: () {

                  //             }),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     verticalSpaceMedium,
    //     Container(
    //       width: thirdScreenWidth(context) * 1.2,
    //       height: thirdScreenWidth(context) * 0.55,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(2),
    //           border: Border.all(
    //             color: kcLightGrey,
    //           )),
    //       child: Column(
    //         children: [
    //           verticalSpaceMedium,
    //           const Padding(
    //             padding: EdgeInsets.only(left: 20),
    //             child: Row(
    //               children: [
    //                 Text(
    //                   "No",
    //                   style: TextStyle(fontWeight: FontWeight.bold),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 90),
    //                   child: Text(
    //                     "FileName",
    //                     style: TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Text(
    //                     "Size",
    //                     style: TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Text(
    //                     "Action",
    //                     style: TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Divider(),
    //           viewModel.extractedList.isNotEmpty
    //               ? ListView.builder(
    //                   itemCount: viewModel.extractedList.length,
    //                   shrinkWrap: true,
    //                   itemBuilder: (context, index) {
    //                     return Padding(
    //                       padding: EdgeInsets.only(left: 20),
    //                       child: Row(
    //                         children: [
    //                           Text(
    //                             (index + 1).toString(),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 90),
    //                             child: Text(
    //                                 viewModel.extractedList[index]["fileName"]),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 60),
    //                             child: Text(viewModel.extractedList[index]
    //                                         ["size"]
    //                                     .toStringAsFixed(2) +
    //                                 " Mb"),
    //                           ),
    //                           Padding(
    //                               padding: const EdgeInsets.only(left: 60),
    //                               child: GestureDetector(
    //                                   onTap: () {
    //                                     viewModel.deleteFile(index);
    //                                   },
    //                                   child: const Icon(
    //                                     Icons.delete,
    //                                     color: kcPrimaryColor,
    //                                     size: 20,
    //                                   ))),
    //                         ],
    //                       ),
    //                     );
    //                   },
    //                 )
    //               : SizedBox(
    //                   height: thirdScreenWidth(context) * 0.4,
    //                   child: const Center(
    //                     child: Text(
    //                       "No File Uploaded So Far",
    //                       style: TextStyle(
    //                         color: kcLightGrey,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       width: thirdScreenWidth(context) * 1.2,
    //       height: 50,
    //       decoration: BoxDecoration(
    //           border: Border.all(
    //         color: kcLightGrey,
    //       )),
    //       child: Row(
    //         children: [
    //           const Spacer(),
    // Button(
    //   textColor: kcVeryLightGrey,
    //   title: "Upload File",
    //   loading: viewModel.isBusy,
    //   height: screenHeight(context) * 0.04,
    //   Color: kcsliderColor,
    //   width: quarterScreenWidth(context) * 0.3,
    //   onTap: () {

    //       viewModel.uploadFile(context);

    //   },
    // ),
    //           horizontalSpaceSmall,
    //           Button(
    //               title: "Proceed",
    //               loading: viewModel.loading,
    //               height: screenHeight(context) * 0.04,
    //               width: quarterScreenWidth(context) * 0.3,
    //               Color: kcsliderColor,
    //               textColor: kcVeryLightGrey,
    //               onTap: () {
    //                 viewModel.onProceed();
    //               }),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}

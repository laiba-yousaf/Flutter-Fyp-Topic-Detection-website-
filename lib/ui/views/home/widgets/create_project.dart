import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';
import '../../../common/app_colors.dart';

class CreateProject extends ViewModelWidget<HomeViewModel> {
  final String heading;
  const CreateProject({super.key, required this.heading});

  @override
  Widget build(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 400, top: 70),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Text(heading,
                  style: const TextStyle(
                      fontSize: 30,
                      color: kcsliderColor,
                      fontWeight: FontWeight.bold)),
            ),
            verticalSpaceMedium,
            const Text("Title of Project",
                style: TextStyle(
                  fontSize: 16,
                  color: kcsliderColor,
                )),
            verticalSpaceSmall,
            Mytextfield(
              title: "Enter the name of your Project",
              textfiledwidth: thirdScreenWidth(context),
              ctrl: viewModel.projectctrl,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Project title is required";
                }
                return null;
              },
              value: 5,
            ),
            verticalSpaceMedium,
            const Text("Description",
                style: TextStyle(fontSize: 16, color: kcsliderColor)),
            verticalSpaceSmall,
            Mytextfield(
                maxlines: 10,
                ctrl: viewModel.descriptionctrl,
                value: 5,
                maxcond: true,
                title: "Enter Project Description(optional)",
                textfiledwidth: thirdScreenWidth(context)),
            verticalSpaceMedium,
            Button(
                textColor: kcVeryLightGrey,
                loading: viewModel.isBusy,
                title: "Save",
                Color: kcPrimaryColor,
                height: screenHeight(context) * 0.06,
                width: thirdScreenWidth(context) * 1.0,
                onTap: () {
                  if (heading == 'Create Project') {
                    if (viewModel.formKey.currentState!.validate()) {
                      viewModel.setcreate(5);
                    }
                  } else if (heading == 'Edit Project') {
                    viewModel.setBusy(true);
                    print("Enter edit Project");
                    //viewModel.fetchData();
                    viewModel.setPage(3,
                        viewModel.firestoreData[viewModel.selectProjectindex]);
                    viewModel.onProceed();
                  }
                })
          ],
        ),
      ),
    );

    // Column(
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
    //                     style:
    //                         TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Text(
    //                     "Size",
    //                     style:
    //                         TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(left: 100),
    //                   child: Text(
    //                     "Action",
    //                     style:
    //                         TextStyle(fontWeight: FontWeight.bold),
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
    //                             padding:
    //                                 const EdgeInsets.only(left: 90),
    //                             child: Text(
    //                                 viewModel.extractedList[index]
    //                                     ["fileName"]),
    //                           ),
    //                           Padding(
    //                             padding:
    //                                 const EdgeInsets.only(left: 60),
    //                             child: Text(viewModel
    //                                     .extractedList[index]
    //                                         ["size"]
    //                                     .toStringAsFixed(2) +
    //                                 " Mb"),
    //                           ),
    //                           Padding(
    //                               padding: const EdgeInsets.only(
    //                                   left: 60),
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
    //           Button(
    //             textColor: kcVeryLightGrey,
    //             title: "Upload File",
    //             loading: viewModel.isBusy,
    //             height: screenHeight(context) * 0.04,
    //             Color: kcsliderColor,
    //             width: quarterScreenWidth(context) * 0.3,
    //             onTap: () {
    //               if (viewModel.formKey.currentState!.validate()) {
    //                 viewModel.uploadFile(context);
    //               }
    //             },
    //           ),
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
    // ),
  }
}

import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';

import '../../widgets/common/button/button.dart';
import '../../widgets/common/uploadmeeting/uploadmeeting.dart';
import 'info_alert_dialog_model.dart';

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      contentPadding: EdgeInsets
          .zero, // Dialog box ki width ko kam karne ke liye contentPadding set karein
      // title: Text(
      //   request.title!,
      //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
      // ),
      content:

          //  Row(
          //    children: [

          //      const Padding(
          //        padding: EdgeInsets.only(top: 120),
          //        child: Column(
          //         children: [
          //           Mytextfield(title: "Enter project name",),
          //           verticalSpaceMedium,
          //           Mytextfield(title: "Enter file type audio/video",),

          //           verticalSpaceMassive,
          //           Button(title: "Create",)
          //         ],
          //        ),
          //      ),

          // horizontalSpacemassiveLarge,
          SizedBox(
              height: 350,
              width: 400,
              child: Card(
                color: Color.fromARGB(255, 244, 231, 245),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      5.0), // Circle radius as per your requirement
                ),
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    ClipOval(
                      child: Image(
                        image: AssetImage(filepic),
                        width: 130,
                        height: 130,
                      ),
                    ),

                    verticalSpaceMedium,
                    const Padding(
                      padding: EdgeInsets.only(left: 110, right: 110),
                      child: Mytextfield(
                        title: "Enter the ProjectName",
                        value: 30,
                      ),
                    ),
                    verticalSpaceMedium,
                    Button(
                      title: "Upload  Meeting",
                      onTap: () async {
                        try {
                          await viewModel.speechtotextservice
                              .uploadAudioFile(context);
                        } catch (e) {
                          print("Error uploading audio file: $e");
                          // Handle the error as needed, e.g., show an error message to the user
                        }
                        //viewModel.updatevalue();
                        //viewModel.navigateTouploadMeeting();
                      },
                    ),
                    verticalSpaceSmall,

                    Padding(
                      padding: const EdgeInsets.only(left: 300),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context, DialogResponse(confirmed: true));
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(
                                color: Color.fromARGB(255, 74, 7, 151)),
                          )),
                    ),
                    verticalSpaceSmall,
                    // const Text("or Drop a file")

                    // Text(
                    //   request.description!,
                    //   style: TextStyle(fontSize: 14, color: kcMediumGrey),
                    //   maxLines: 3,
                    //   softWrap: true,
                    // ),
                  ],
                ),
              )),

      // ),
      // actions: [
      //   TextButton(
      //     onPressed: () => completer(DialogResponse(confirmed: true)),
      //     child: const Text(
      //       'Create',
      //       style: TextStyle(
      //         color: Color.fromARGB(255, 115, 45, 129),
      //         fontWeight: FontWeight.bold,
      //         fontSize: 16,
      //       ),
      //     ),
      //   ),
      // ],
    );

    // Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   backgroundColor: Colors.white,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Expanded(
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     request.title!,
    //                     style: const TextStyle(
    //                         fontSize: 16, fontWeight: FontWeight.w900),
    //                   ),
    //                   verticalSpaceTiny,
    //                   Text(
    //                     request.description!,
    //                     style:
    //                         const TextStyle(fontSize: 14, color: kcMediumGrey),
    //                     maxLines: 3,
    //                     softWrap: true,
    //                   ),
    //                 ],
    //               ),
    //             ),

    //           ],
    //         ),
    //         verticalSpaceMedium,
    //         GestureDetector(
    //           onTap: () => completer(DialogResponse(
    //             confirmed: true,
    //           )),
    //           child: Container(
    //             height: 50,
    //             width: double.infinity,
    //             alignment: Alignment.center,
    //             decoration: BoxDecoration(
    //               color: Colors.black,
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             child: const Text(
    //               'Got it',
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

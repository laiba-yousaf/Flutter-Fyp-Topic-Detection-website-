import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';

import '../../common/ui_helpers.dart';
import 'uploadmeeting_viewmodel.dart';

class UploadmeetingView extends StackedView<UploadmeetingViewModel> {
  const UploadmeetingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UploadmeetingViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Image(
          image: AssetImage(backgroundimg),
          width: screenWidth(context),
          fit: BoxFit.cover,
        ),
        const Positioned(
            left: 40,
            top: 180,
            child: Text("Topic Discussed in \n \t\t\t Meeting",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
        Positioned(
            left: 480,
            top: 100,
            child: SizedBox(
              //height: 200,
              width: 200,
              // color: Colors.black,
              child: Image(
                image: AssetImage(stackimg),
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
            left: 840,
            top: 100,
            child: SizedBox(
                height: 300,
                width: 400,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30.0), // Circle radius as per your requirement
                    ),
                    child: Column(
                      children: [
                        verticalSpaceMedium,
                        const Text("Your file uploading"),
                        verticalSpaceMedium,
                        const Text(
                          "39%",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        verticalSpaceMedium,
                        Center(
                          child: Container(
                            //color: Colors.amber,
                            //height: 35,
                            width: 200,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.file_open,
                                  size: 20,
                                ),
                                horizontalSpaceMedium,
                                const Text(
                                  "Meeting with laiba.mp3",
                                  style: TextStyle(fontSize: 10),
                                ),
                                horizontalSpaceMedium,
                                Image(
                                  image: AssetImage(cancelicon),
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        Button(
                          title: "Upload  Meeting",
                          onTap: () {},
                        ),
                        verticalSpaceSmall,
                        const Text("or Drop a file")
                      ],
                    ))))
      ],
    );
  }

  @override
  UploadmeetingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UploadmeetingViewModel();
}

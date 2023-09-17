import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/aboutus/cardwidget.dart';

import 'aboutus_viewmodel.dart';

class AboutusView extends StackedView<AboutusViewModel> {
  const AboutusView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AboutusViewModel viewModel,
    Widget? child,
  ) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About us",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          verticalSpaceMedium,
          Center(
            child: Text(
              "Topic detection from urdu meeting.It is our fyp under the \n supervision of Dr.Farah Adeeba",
              style: TextStyle(fontSize: 16),
            ),
          ),
          verticalSpaceLarge,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardWidget(
                  pic: "pic", name: "Najm", description: "I am from RANA TOWN"),
              horizontalSpaceSmall,
              CardWidget(
                  pic: "pic", name: "Kashif", description: "I am from PASROOR"),
              horizontalSpaceSmall,
              CardWidget(
                  pic: "pic", name: "Laiba", description: "I am from LAHORE"),
            ],
          )
        ],
      ),
    );
  }

  @override
  AboutusViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AboutusViewModel();
}

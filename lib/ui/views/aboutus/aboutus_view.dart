import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
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
      padding: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About us",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          //horizontalSpaceMedium,
          //Image(image: AssetImage(about),width: 400,),
          verticalSpaceMedium,

          Text(
            "We're a dedicated team working on Topic Detection from Urdu Meetings.Our mission extract",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
          verticalSpaceSmall,
          Text(
            "valuable insights from spoken Urdu meetings to enhance decision-making and content retrieval.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
          verticalSpaceSmall,
          Text(
            "Guided by Dr .Farah Aeeba, our expertise  in NLP drives a powerful, user-friendly solution.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
          verticalSpaceSmall,
          Text(
            "Join us on this journey of discovery!",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
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

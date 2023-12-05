import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/aboutus/widget/card.dart';
import 'aboutus_viewmodel.dart';

class AboutusView extends StackedView<AboutusViewModel> {
  const AboutusView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AboutusViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "About us",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            verticalSpaceMedium,
            const Padding(
              padding: EdgeInsets.only(left: 300),
              child: Text(
                "We're a dedicated team working on Topic Detection from Urdu Meetings.Our mission extract",
                style: TextStyle(fontSize: 16),
              ),
            ),
            verticalSpaceSmall,
            const Padding(
              padding: EdgeInsets.only(left: 300),
              child: Text(
                "valuable insights from spoken Urdu meetings to enhance decision-making and content .",
                style: TextStyle(fontSize: 16),
              ),
            ),
            verticalSpaceSmall,
            const Padding(
              padding: EdgeInsets.only(left: 300),
              child: Text(
                "retrieval Guided by Dr .Farah Aeeba, our expertise  in NLP drives a powerful user-friendly,",
                style: TextStyle(fontSize: 16),
              ),
            ),
            verticalSpaceSmall,
            const Padding(
              padding: EdgeInsets.only(left: 300),
              child: Text(
                "solution.Join us on this journey of discovery!",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
            verticalSpaceLarge,
            Padding(
              padding: EdgeInsets.only(left: 90),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cardwidget(
                    pic: laiba,
                    name: "Laiba",
                    description:
                        "     Final-year BSCS student specializing \n    in front-end and back-end development\n    with expertise in seamless modal integration,\n    contributing to the success of our project. ",
                  ),
                  horizontalSpaceSmall,
                  Cardwidget(
                    pic: kashif,
                    name: "Kashif",
                    description:
                        "     Final-year BSCS student specializing in \n     modal creation, imparting valuable \n     training and expertise  to elevate user\n     experiences., contributing to the \n     success of our project.",
                  ),
                  horizontalSpaceSmall,
                  Cardwidget(
                    pic: najm,
                    name: "Najm",
                    description:
                        "     Final-year BSCS student specializing in \n     modal creation, imparting valuable \n     training and expertise  to elevate user\n     experiences., contributing to the \n     success of our project.",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  AboutusViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AboutusViewModel();
}

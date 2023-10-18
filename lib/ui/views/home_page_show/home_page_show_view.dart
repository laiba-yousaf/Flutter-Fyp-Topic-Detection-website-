import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import 'home_page_show_viewmodel.dart';

class HomePageShowView extends StackedView<HomePageShowViewModel> {
  const HomePageShowView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomePageShowViewModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceMassive,
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 100),
              child: Column(
                children: [
                  Text(
                    "TOPIC DISCUSSED",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  verticalSpaceSmall,
                  Text(
                    "IN MEETING",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            horizontalSpacemassiveLarge,
            Image(
              image: AssetImage(backgroundimg),
              width: 600,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 110),
          child: Button(
            textColor: kcVeryLightGrey,
            Color: kcPrimaryColor,
            height: screenHeight(context) * 0.06,
            width: quarterScreenWidth(context) * 0.5,
            title: "Create Project",
            onTap: () {
              viewModel.updatevalue();
            },
          ),
        )
      ],
    );
  }

  @override
  HomePageShowViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomePageShowViewModel();
}

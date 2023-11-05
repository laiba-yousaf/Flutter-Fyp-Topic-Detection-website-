import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../home/home_viewmodel.dart';
import 'dashborad_viewmodel.dart';

class DashboradView extends StackedView<DashboradViewModel> {
  final HomeViewModel homeViewModel;

  const DashboradView({Key? key, required this.homeViewModel})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboradViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 300),
      child: Column(
        children: [
          const Text(
            "DashBoard",
            style: TextStyle(color: kcsliderColor, fontSize: 40),
          ),
          verticalSpaceMassive,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) {
                  viewModel.setcontainer1(hoverColor, 10.0);
                },
                onExit: (_) {
                  viewModel.setcontainer1(kcVeryLightGrey, 0.0);
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: viewModel.color1,
                  ),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          homeViewModel.setcreate(4);
                        },
                        child: SvgPicture.asset(
                          createProject,
                          width: 150,
                          height: 150,
                        ),
                      ),
                      verticalSpaceSmall,
                      const Text(
                        "Create Projects",
                        style: TextStyle(fontSize: 20, color: kcsliderColor),
                      )
                    ],
                  ),
                ),
              ),
              horizontalSpacemassiveLarge,
              MouseRegion(
                onEnter: (_) {
                  viewModel.setcontainer2(hoverColor1, 10.0);
                },
                onExit: (_) {
                  viewModel.setcontainer2(kcVeryLightGrey, 0.0);
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: viewModel.color2,
                  ),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceSmall,
                      InkWell(
                        onTap: () {
                          homeViewModel.setcreate(7);
                        },
                        child: SvgPicture.asset(
                          viewProject,
                          width: 150,
                          height: 150,
                        ),
                      ),
                      verticalSpaceSmall,
                      const Text(
                        "View Projects",
                        style: TextStyle(fontSize: 20, color: kcsliderColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  DashboradViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboradViewModel();
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/dashborad/dashborad_view.dart';
import 'package:topicdetectionweb/ui/views/historypage/historypage_view.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/views/home/widgets/create_project.dart';
import 'package:topicdetectionweb/ui/widgets/common/sidebarx_widget/sidebarx_widget.dart';

import 'widgets/uploadfile.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 202, 163, 253)),
        key: viewModel.key,
        body: Stack(children: [
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(newbackground), fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 150, top: 10, right: 10),
              child: Container(
                height: screenHeight(context) * 0.8,
                width: screenWidth(context) * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kcVeryLightGrey.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Row(
            children: [
              SidebarxWidget(controller: viewModel.controller),
              AnimatedBuilder(
                animation: viewModel.controller,
                builder: (context, child) {
                  switch (viewModel.controller.selectedIndex) {
                    case 0:
                      return DashboradView(homeViewModel: viewModel);
                    //return const CreateProject();
                    //return HomePageShowView(homeViewModel: viewModel);
                    case 1:
                      return HistorypageView(homeViewModel: viewModel);
                    case 2:
                      viewModel.logout();
                      return Container();
                    case 3:
                      return const CreateProject(
                        heading: "Edit Project",
                      );
                    case 4:
                      return const CreateProject(
                        heading: "Create Project",
                      );
                    case 5:
                      return Uploadfile(
                        projectname: viewModel.projectctrl.text,
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ],
          ),
        ]),
      );
    });
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/views/historypage/historypage_view.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/views/home/widgets/create_project.dart';
import 'package:topicdetectionweb/ui/widgets/common/sidebarx_widget/sidebarx_widget.dart';

import '../home_page_show/home_page_show_view.dart';

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
        key: viewModel.key,
        body: Row(
          children: [
            SidebarxWidget(controller: viewModel.controller),
            AnimatedBuilder(
              animation: viewModel.controller,
              builder: (context, child) {
                switch (viewModel.controller.selectedIndex) {
                  case 0:
                    //return const CreateProject();
                    return HomePageShowView(homeViewModel: viewModel);
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

                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

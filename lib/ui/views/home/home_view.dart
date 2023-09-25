import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/views/aboutus/aboutus_view.dart';
import 'package:topicdetectionweb/ui/views/contactus/contactus_view.dart';
import 'package:topicdetectionweb/ui/views/historypage/historypage_view.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/views/home_page_show/home_page_show_view.dart';
import 'package:topicdetectionweb/ui/views/signin/signin_view.dart';
import 'package:topicdetectionweb/ui/views/uploadmeeting/uploadmeeting_view.dart';
import 'package:topicdetectionweb/ui/widgets/common/sidebarx_widget/sidebarx_widget.dart';

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

        // Set the endDrawer to SidebarxWidget

        body: Row(
          children: [
            SidebarxWidget(controller: viewModel.controller),
            AnimatedBuilder(
              animation: viewModel.controller,
              builder: (context, child) {
                switch (viewModel.controller.selectedIndex) {
                  case 0:
                    return HomePageShowView();

                  // case 1:
                  //   return UploadmeetingView();
                  case 2:
                    return AboutusView();
                  case 3:
                    return ContactusView();
                  case 4:
                    return HistorypageView();
                  case 5:
                    viewModel.authservice.logout();
                    return viewModel.navigationLandingPage();
                  // Additional code to navigate to the login page or perform other actions

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

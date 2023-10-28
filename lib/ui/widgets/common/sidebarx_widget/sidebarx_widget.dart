import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'sidebarx_widget_model.dart';

class SidebarxWidget extends StackedView<SidebarxWidgetModel> {
  const SidebarxWidget({super.key, required this.controller});
  final SidebarXController controller;

  @override
  Widget builder(
    BuildContext context,
    SidebarxWidgetModel viewModel,
    Widget? child,
  ) {
    return SidebarX(
      headerBuilder: (context, extended) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image(
            image: AssetImage(logopic),
            width: 50,
            height: 50,
          ),
        );
      },
      controller: controller,
      theme: const SidebarXTheme(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 202, 161, 248),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      items: const [
        SidebarXItem(
          label: "DashBoard",
          icon: Icons.home,
        ),
        SidebarXItem(icon: Icons.history, label: "View Projects"),
        SidebarXItem(icon: Icons.logout, label: "Logout"),
      ],
      extendedTheme: const SidebarXTheme(width: 140),
    );
  }

  @override
  SidebarxWidgetModel viewModelBuilder(
    BuildContext context,
  ) =>
      SidebarxWidgetModel();
}

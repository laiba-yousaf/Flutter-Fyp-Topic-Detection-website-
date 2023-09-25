import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:stacked/stacked.dart';

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
      controller: controller,
      theme: const SidebarXTheme(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 179, 121, 245),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          iconTheme: IconThemeData(color: Colors.white)),

      items: const [
        SidebarXItem(icon: Icons.home, label: "Home",),
        SidebarXItem(icon: Icons.upload_file, label: "Upload"),
        SidebarXItem(icon: Icons.group, label: "About us"),
        SidebarXItem(icon: Icons.contact_page, label: "Contact us"),
        SidebarXItem(icon: Icons.history, label: "History"),
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

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/contactus/contactwidget.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';

import 'contactus_viewmodel.dart';

class ContactusView extends StackedView<ContactusViewModel> {
  const ContactusView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ContactusViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      
        const Text(
          "Contact us",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        verticalSpaceSmall,
        const Text(
          "Get in touch with us",
          //style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        verticalSpaceLarge,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            contactwidget(Icons.location_on, "123,city,lahore"),
            horizontalSpaceMedium,
            contactwidget(Icons.email, "example@gmail.com"),
            horizontalSpaceMedium,
            contactwidget(Icons.phone, "+9234567899"),
          ],
        ),
        verticalSpaceLarge,
        Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpacemassiveLarge,
            horizontalSpaceLarge,
            horizontalSpaceLarge,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email"),
                Mytextfield(
                  title: "example@gmail.com",
                  ctrl: viewModel.mailctrl,
                ),
                verticalSpaceSmall,
                const Text("phone"),
                verticalSpaceSmall,
                Mytextfield(
                  title: "12345678",
                  ctrl: viewModel.phonectrl,
                ),
                verticalSpaceMedium,
                Button(
                  title: "Submit",
                  onTap: () {},
                )
              ],
            ),
            horizontalSpaceLarge,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Message"),
                verticalSpaceSmall,
                Mytextfield(
                  title: "write your message....",
                  ctrl: viewModel.msgctrl,
                  maxlines: 5,
                  maxcond: true,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  @override
  ContactusViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ContactusViewModel();
}

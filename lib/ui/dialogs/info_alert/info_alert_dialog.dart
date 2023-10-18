import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';
import '../../widgets/common/button/button.dart';
import 'info_alert_dialog_model.dart';

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  // Method to show the first dialog

  // Method to show the second dialog
  void _showSecondDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Second Dialog'),
          content: Column(
            children: [
              // Add your content for the second dialog here
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      // Add your main dialog content here
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 120),
            child: Column(
              children: [
             Mytextfield(
                  title: "Enter project name",
                    textfiledwidth: quarterScreenWidth(context),
                  value: 30,
                ),
                verticalSpaceMedium,
                 Mytextfield(
                  title: "Enter file type audio/video",
                    textfiledwidth: quarterScreenWidth(context),
                  value: 30,
                ),
                verticalSpaceMedium,
                TextButton(
                    onPressed: () {
                      viewModel.showFirstDialog(context);
                    },
                    child: const Text(
                      "Upload Meeting",
                      style: TextStyle(color: Colors.purple),
                    )),
                verticalSpaceMassive,
           Button(
            textColor: kcVeryLightGrey,
             Color:kcPrimaryColor,
                   height: screenHeight(context) * 0.06,
              width: quarterScreenWidth(context) * 0.5,
                  title: "Create",
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // TextButton(
        //   child: Text('Show First Dialog'),
        //   onPressed: () {
        //     _showFirstDialog(context);
        //   },
        // ),
        // TextButton(
        //   child: Text('Show Second Dialog'),
        //   onPressed: () {
        //     _showSecondDialog(context);
        //   },
        // ),
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

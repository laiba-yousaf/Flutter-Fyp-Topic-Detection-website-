import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/ui/dialogs/info_alert/info_alert_dialog_model.dart';

class ZoomIN extends ViewModelWidget<InfoAlertDialogModel> {
  final String text;
  const ZoomIN({super.key, required this.text});

  @override
  Widget build(
    BuildContext context,
    InfoAlertDialogModel viewModel,
  ) {
    return Column(
      children: [
        Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                viewModel.setzoomIN();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                viewModel.setzoomOut();
              },
            ),
          ],
        ),
        GestureDetector(
          onScaleUpdate: (details) {
            viewModel.setscale(details.scale);
          },
          onScaleEnd: (details) {
            viewModel.previousScale = viewModel.scale;
          },
          child: Transform.scale(
            scale: viewModel.scale,
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'NotoNastaliqUrdu',
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

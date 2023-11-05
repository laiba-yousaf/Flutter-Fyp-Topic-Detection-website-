// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/delete_project/delete_project_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/selectfile_dialog/selectfile_dialog_dialog.dart';

enum DialogType {
  infoAlert,
  selectfileDialog,
  deleteProject,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.selectfileDialog: (context, request, completer) =>
        SelectfileDialogDialog(request: request, completer: completer),
    DialogType.deleteProject: (context, request, completer) =>
        DeleteProjectDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

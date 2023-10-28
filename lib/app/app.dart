import 'package:topicdetectionweb/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:topicdetectionweb/ui/dialogs/info_alert/info_alert_dialog.dart';

import 'package:topicdetectionweb/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/ui/views/signup/signup_view.dart';
import 'package:topicdetectionweb/ui/views/signin/signin_view.dart';
import 'package:topicdetectionweb/ui/views/home/home_view.dart';
import 'package:topicdetectionweb/ui/views/historypage/historypage_view.dart';
import 'package:topicdetectionweb/ui/views/aboutus/aboutus_view.dart';
import 'package:topicdetectionweb/ui/views/contactus/contactus_view.dart';
import 'package:topicdetectionweb/services/toastmessage_service.dart';
import 'package:topicdetectionweb/services/authentication_service.dart';
import 'package:topicdetectionweb/ui/views/landing_page/landing_page_view.dart';
import 'package:topicdetectionweb/services/speech_to_text_service.dart';
import 'package:topicdetectionweb/services/firestoredata_service.dart';
import 'package:topicdetectionweb/ui/views/dashborad/dashborad_view.dart';
import 'package:topicdetectionweb/ui/dialogs/selectfile_dialog/selectfile_dialog_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: SigninView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: HistorypageView),
    MaterialRoute(page: AboutusView),
    MaterialRoute(page: ContactusView),
    MaterialRoute(page: LandingPageView),
    MaterialRoute(page: DashboradView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ToastmessageService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: SpeechToTextService),
    LazySingleton(classType: FirestoredataService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: SelectfileDialogDialog),
// @stacked-dialog
  ],
)
class App {}

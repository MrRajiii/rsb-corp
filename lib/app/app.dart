import 'package:rsbweb_v1/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:rsbweb_v1/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:rsbweb_v1/ui/dialogs/inquiry/inquiry_dialog.dart';
import 'package:rsbweb_v1/ui/views/home/home_view.dart';
import 'package:rsbweb_v1/ui/views/project_detail/project_detail_view.dart';
import 'package:rsbweb_v1/ui/views/startup/startup_view.dart';
import 'package:rsbweb_v1/ui/views/two_storey/two_storey_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:rsbweb_v1/ui/views/bungalow/bungalow_view.dart';
import 'package:rsbweb_v1/ui/views/constructionworks/constructionworks_view.dart';
import 'package:rsbweb_v1/ui/views/interiordesign/interiordesign_view.dart';
import 'package:rsbweb_v1/ui/views/finishedprojects/finishedprojects_view.dart';
import 'package:rsbweb_v1/ui/views/company_profile/company_profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: BungalowView),
    MaterialRoute(page: TwoStoreyView),
    MaterialRoute(page: ConstructionWorksView),
    MaterialRoute(page: InteriorDesignView),
    MaterialRoute(page: FinishedProjectsView),
    MaterialRoute(page: ProjectDetailView),
    MaterialRoute(page: CompanyProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: InquiryDialog),
    // @stacked-dialog
  ],
)
class App {}

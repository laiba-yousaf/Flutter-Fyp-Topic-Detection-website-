import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/app/app.router.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/aboutus/aboutus_view.dart';
import 'package:topicdetectionweb/ui/views/contactus/contactus_view.dart';
import 'package:topicdetectionweb/ui/views/historypage/historypage_view.dart';
import 'package:topicdetectionweb/ui/views/uploadmeeting/uploadmeeting_view.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';

import 'buttoncolor.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: Stack(
      children: [
        Image(
          image: AssetImage(backgroundimg),
          width: screenWidth(context),
          fit: BoxFit.cover,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500), // Animation duration
          width: viewModel.isExpanded
              ? 200
              : 70, // Expand width when isExpanded is true
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 138, 108, 247),
          ),
          child: viewModel.isExpanded
              ? Column(
                  children: [
                    verticalSpaceLarge,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(Icons.home, color: Colors.white),
                          onTap: () {},
                        ),
                        horizontalSpaceSmall,
                        Text(
                          "Home",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file, color: Colors.white),
                        horizontalSpaceSmall,
                        Text(
                          "Upload",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(Icons.history, color: Colors.white),
                          onTap: () {
                            viewModel.navigationhistorypage();
                          },
                        ),
                        horizontalSpaceSmall,
                        Text(
                          "History",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group, color: Colors.white),
                        horizontalSpaceSmall,
                        Text(
                          "About us",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.contact_page, color: Colors.white),
                        horizontalSpaceSmall,
                        Text(
                          "Contact us",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                    verticalSpaceLarge,
                    GestureDetector(
                      onTap: () {
                        viewModel.expandstate();
                      },
                      child: Icon(
                        viewModel.isExpanded
                            ? Icons.arrow_left_outlined
                            : Icons.arrow_right_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    verticalSpaceLarge,
                    Icon(Icons.home, color: Colors.white),
                    verticalSpaceMedium,
                    Icon(Icons.upload_file, color: Colors.white),
                    verticalSpaceMedium,
                    Icon(Icons.contact_page, color: Colors.white),
                    verticalSpaceMedium,
                    Icon(Icons.group, color: Colors.white),
                    verticalSpaceMedium,
                    Icon(Icons.history, color: Colors.white),
                    verticalSpaceLarge,
                    GestureDetector(
                      onTap: () {
                        viewModel.expandstate();
                      },
                      child: Icon(
                        viewModel.isExpanded
                            ? Icons.arrow_left_outlined
                            : Icons.arrow_right_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ],
                ),
        ),
        viewModel.isExpanded
            ? Positioned(
                left: 250,
                top: 180,
                child: Text("Topic Discussed in \n \t\t\t Meeting",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)))
            : Positioned(
                left: 90,
                top: 180,
                child: Text("Topic Discussed in \n \t\t\t Meeting",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
        viewModel.isExpanded
            ? Positioned(
                left: 580,
                top: 100,
                child: SizedBox(
                  //height: 200,
                  width: 200,
                  // color: Colors.black,
                  child: Image(
                    image: AssetImage(stackimg),
                    fit: BoxFit.cover,
                  ),
                ))
            : Positioned(
                left: 480,
                top: 100,
                child: SizedBox(
                  //height: 200,
                  width: 200,
                  // color: Colors.black,
                  child: Image(
                    image: AssetImage(stackimg),
                    fit: BoxFit.cover,
                  ),
                )),
        Positioned(
            left: 840,
            top: 100,
            child: SizedBox(
              height: 300,
              width: 400,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Circle radius as per your requirement
                  ),
                  child: Column(
                    children: [
                      verticalSpaceMedium,
                      Image(
                          image: AssetImage(filepic), width: 100, height: 100),
                      verticalSpaceMedium,
                      Button(
                        title: "Upload Meeting",
                        onTap: () {
                          viewModel.setCurrentPage("Upload Meeting");
                        },
                      ),
                      verticalSpaceSmall,
                      const Text("or Drop a file")
                    ],
                  )),
            ))
      ],
    ));
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

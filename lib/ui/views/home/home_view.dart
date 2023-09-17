import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 116, 12, 214),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("NLP logo"),
        ),
        actions: [
          buildButtonWithBorder(
            text: 'Home',
            isSelected: viewModel.currentPage == 'Home',
            onPressed: () {
              viewModel.setCurrentPage('Home');
            },
          ),
          buildButtonWithBorder(
            text: 'History',
            isSelected: viewModel.currentPage == 'History',
            onPressed: () {
              viewModel.setCurrentPage('History');
            },
          ),
          buildButtonWithBorder(
            text: 'About us',
            isSelected: viewModel.currentPage == 'About us',
            onPressed: () {
              viewModel.setCurrentPage('About us');
            },
          ),
          buildButtonWithBorder(
            text: 'Contact us',
            isSelected: viewModel.currentPage == 'Contact us',
            onPressed: () {
              viewModel.setCurrentPage('Contact us');
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (viewModel.currentPage == 'Home') {
            return Stack(
              children: [
                Image(
                  image: AssetImage(backgroundimg),
                  width: screenWidth(context),
                  fit: BoxFit.cover,
                ),
                const Positioned(
                    left: 40,
                    top: 180,
                    child: Text("Topic Discussed in \n \t\t\t Meeting",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                Positioned(
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
                                  image: AssetImage(filepic),
                                  width: 100,
                                  height: 100),
                              verticalSpaceMedium,
                              Button(
                                title: "Upload Meeting",
                                onTap: () {
                                  viewModel.setCurrentPage("Upload Meeting");
                                  print("page not move");
                                },
                              ),
                              verticalSpaceSmall,
                              const Text("or Drop a file")
                            ],
                          )),
                    ))
              ],
            );
          } else if (viewModel.currentPage == 'History') {
            // Render the History page content
            return const HistorypageView();
          } else if (viewModel.currentPage == 'About us') {
            // Render the History page content
            return const AboutusView();
          } else if (viewModel.currentPage == 'Contact us') {
            // Render the History page content
            return const ContactusView();
          } else if (viewModel.currentPage == 'Upload Meeting') {
            // Render the History page content
            return const UploadmeetingView();
          }

          return Container(); // Return an empty container if no page is selected.
        },
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

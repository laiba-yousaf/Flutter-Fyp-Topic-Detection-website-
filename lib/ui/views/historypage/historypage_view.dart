import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/historypage/project_card.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'historypage_viewmodel.dart';

class HistorypageView extends StackedView<HistorypageViewModel> {
  final HomeViewModel homeViewModel;

  const HistorypageView({Key? key, required this.homeViewModel})
      : super(key: key);
  @override
  void onViewModelReady(HistorypageViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.fetchData();
  }

  @override
  Widget builder(
    BuildContext context,
    HistorypageViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context) * 0.82,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            children: [
              const Text(
                "View Projects",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 100),
                            child: Text(
                              "No",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 200),
                            child: Text(
                              "ProjectName",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 200),
                            child: Text(
                              "Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 280),
                            child: Text(
                              "Action",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      ListView.builder(
                        itemCount: viewModel.firestoreData.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProjectCardHistory(
                              projectData: viewModel.firestoreData[index],
                              index: index,
                              homeViewModel: homeViewModel);
                        },
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HistorypageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HistorypageViewModel();
}

// Expanded(
//   flex: 1,
//   child: Padding(
//     padding: const EdgeInsets.only(top: 25, right: 20),
//     child: ProjectDetails(
//       homeViewModel: homeViewModel,
//     ),
//   ),
// )

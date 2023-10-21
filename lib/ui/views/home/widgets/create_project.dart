import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/home/home_viewmodel.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';
import '../../../common/app_colors.dart';

class CreateProject extends ViewModelWidget<HomeViewModel> {
  final HomeViewModel homeViewModel;
  const CreateProject({required this.homeViewModel, super.key});

  @override
  Widget build(
    BuildContext context,
    HomeViewModel viewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 100),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Project",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            verticalSpaceLarge,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text("Title of Project",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    verticalSpaceSmall,
                    Mytextfield(
                      title: "Enter the name of your Project",
                      textfiledwidth: thirdScreenWidth(context),
                      ctrl: viewModel.projectctrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Project title is required";
                        }
                        return null;
                      },
                      value: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Description",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        verticalSpaceSmall,
                        Mytextfield(
                            maxlines: 10,
                            value: 5,
                            maxcond: true,
                            title: "Enter Project Description(optional)",
                            textfiledwidth: thirdScreenWidth(context)),
                      ],
                    ),
                  ],
                ),
                horizontalSpaceMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceSmall,
                    verticalSpaceSmall,
                    Container(
                      width: thirdScreenWidth(context),
                      height: quarterScreenWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: kcLightGrey,
                          )),
                      child: viewModel.extractedList.isNotEmpty
                          ? ListView.builder(
                              itemCount: viewModel.extractedList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Text((index + 1).toString()),
                                  title: Text(viewModel.extractedList[index]
                                      ["fileName"]),
                                  subtitle: Text(viewModel.extractedList[index]
                                          ["size"]
                                      .toString()),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "No File Uploaded So Far",
                                style: TextStyle(
                                  color: kcLightGrey,
                                ),
                              ),
                            ),
                    ),
                    Container(
                      width: thirdScreenWidth(context),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: kcLightGrey,
                      )),
                      child: Row(
                        children: [
                          const Spacer(),
                          Button(
                            textColor: kcVeryLightGrey,
                            title: "Upload File",
                            loading: viewModel.isBusy,
                            height: screenHeight(context) * 0.04,
                            Color: kcsliderColor,
                            width: quarterScreenWidth(context) * 0.3,
                            onTap: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                viewModel.uploadFile(context);
                              }
                            },
                          ),
                          horizontalSpaceSmall,
                          Button(
                              title: "Proceed",
                              loading: viewModel.loading,
                              height: screenHeight(context) * 0.04,
                              width: quarterScreenWidth(context) * 0.3,
                              Color: kcsliderColor,
                              textColor: kcVeryLightGrey,
                              onTap: () {
                                viewModel.onProceed();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

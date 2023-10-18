import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';
import 'package:topicdetectionweb/ui/widgets/common/mytextfield/mytextfield.dart';
import '../../../common/app_colors.dart';
import 'create_project_model.dart';

class CreateProject extends StackedView<CreateProjectModel> {
  const CreateProject({super.key});

  @override
  Widget builder(
    BuildContext context,
    CreateProjectModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 50, top: 100),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Project",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            verticalSpaceLarge,
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //verticalSpaceLarge,
                    const Text("Title of Project",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Mytextfield(
                      title: "Enter the name of your Project",
                      textfiledwidth: thirdScreenWidth(context),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Project title is required";
                        }
                      },
                      value: 5,
                    ),
                  ],
                ),
                horizontalSpaceMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("File Type",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Mytextfield(
                      title: "Select file type",
                      suffix: DropdownButtonFormField<String>(
                        value: viewModel
                            .selectedFileType, // This should be a property in your view model to track the selected value
                        onChanged: (newValue) {
                          viewModel.setSelectedFileType(
                              newValue); // Update the selected value in the view model
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "File Type is required";
                          }
                        },
                        items: viewModel.fileTypes.map((fileType) {
                          return DropdownMenuItem<String>(
                            value: fileType,
                            child: Text(fileType),
                          );
                        }).toList(),
                      ),
                      textfiledwidth: thirdScreenWidth(context),
                      value: 5,
                    ),
                  ],
                ),
              ],
            ),
            // 2nd row
            verticalSpaceMedium,

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Mytextfield(
                        maxlines: 10,
                        value: 5,
                        maxcond: true,
                        title: "Enter Project Description(optional)",
                        textfiledwidth: thirdScreenWidth(context)),
                  ],
                ),
                horizontalSpaceMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpaceSmall,
                    Container(
                      width: thirdScreenWidth(context),
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: const Color.fromARGB(255, 163, 160, 160),
                          )),
                      child: viewModel.ExtractedList.isNotEmpty
                          ? ListView.builder(
                              itemCount: viewModel.ExtractedList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Text((index + 1)
                                      .toString()), // Auto-incremented number
                                  title: Text(viewModel.ExtractedList[index]
                                      [0]), // File name
                                  subtitle: Text(
                                      DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                          viewModel.ExtractedList[index][2]
                                              .toDate())), // Timestamp
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "No File Uploaded So Far",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 163, 160, 160),
                                ),
                              ),
                            ),
                      //color: Colors.amber,
                    ),
                    Container(
                      width: thirdScreenWidth(context),
                      height: 50,
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                        color: const Color.fromARGB(255, 163, 160, 160),
                      )),

                      child: Row(
                        children: [
                          const Spacer(),
                          Button(
                            textColor: kcDarkGreyColor,
                            title: "Upload File",
                            loading: viewModel.loading,
                            height: screenHeight(context) * 0.04,
                            Color: kcVeryLightGrey,
                            width: quarterScreenWidth(context) * 0.3,
                            onTap: () {
                              if (viewModel.formKey.currentState!.validate()) {
                                //viewModel.setloadingvalue(true);
                                viewModel.uploadFile(context);
                              
                              }
                            },
                          ),
                          horizontalSpaceSmall,
                          Button(
                            title: "Proceed",
                            height: screenHeight(context) * 0.04,
                            width: quarterScreenWidth(context) * 0.3,
                            Color: kcVeryLightGrey,
                            textColor: kcDarkGreyColor,
                          ),
                        ],
                      ),
                      //color: Colors.amber,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  CreateProjectModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateProjectModel();
}

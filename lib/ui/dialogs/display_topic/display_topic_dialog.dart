// import 'package:flutter/material.dart';
// import 'package:topicdetectionweb/ui/common/app_colors.dart';
// import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// import 'display_topic_dialog_model.dart';

// class DisplayTopicDialog extends StackedView<DisplayTopicDialogModel> {
//   final DialogRequest request;
//   final Function(DialogResponse) completer;

//   const DisplayTopicDialog({
//     Key? key,
//     required this.request,
//     required this.completer,
//   }) : super(key: key);

//   @override
//   Widget builder(
//     BuildContext context,
//     DisplayTopicDialogModel viewModel,
//     Widget? child,
//   ) {
//      return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       backgroundColor: Colors.white,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             verticalSpaceMassive,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Summary',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     completer(DialogResponse(confirmed: true));
//                   },
//                   child: const Icon(
//                     Icons.close,
//                     color: kcsliderColor,
//                   ),
//                 ),
//               ],
//             ),
//             verticalSpaceMedium,
//             if (request.data['segment'] != null)
//               for (int i = 0; i < request.data['segment']!.length; i++)
//                 Text(
//                   'Segment ${i + 1}:\n${request.data['segment']![i].replaceAll('            ', '')}', //RegExp(r'\s+'),'      ')}',
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.right,
//                 ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   DisplayTopicDialogModel viewModelBuilder(BuildContext context) =>
//       DisplayTopicDialogModel(request.data['summary']);
// }

//2nd code

// import 'package:flutter/material.dart';
// import 'package:topicdetectionweb/ui/common/app_colors.dart';
// import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// import 'display_topic_dialog_model.dart';

// class DisplayTopicDialog extends StackedView<DisplayTopicDialogModel> {
//   final DialogRequest request;
//   final Function(DialogResponse) completer;

//   const DisplayTopicDialog({
//     Key? key,
//     required this.request,
//     required this.completer,
//   }) : super(key: key);

//   @override
//   Widget builder(
//     BuildContext context,
//     DisplayTopicDialogModel viewModel,
//     Widget? child,
//   ) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       backgroundColor: Colors.white,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             verticalSpaceMassive,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Summary',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     completer(DialogResponse(confirmed: true));
//                   },
//                   child: const Icon(
//                     Icons.close,
//                     color: kcsliderColor,
//                   ),
//                 ),
//               ],
//             ),
//             verticalSpaceMedium,
//             FutureBuilder<List<List<String>>>(
//               future: viewModel.getSummariesFromFirestore(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Text('No summaries available.');
//                 } else {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: snapshot.data!.asMap().entries.map((entry) {
//                       int segmentNumber = entry.key + 1;
//                       List<String> summaryList = entry.value;

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Segment $segmentNumber:',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           ...summaryList.map((summary) {
//                             return Text(
//                               summary,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.right,
//                             );
//                           }),
//                         ],
//                       );
//                     }).toList(),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   DisplayTopicDialogModel viewModelBuilder(BuildContext context) =>
//       DisplayTopicDialogModel();
// }

//3rd code

import 'package:flutter/material.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'display_topic_dialog_model.dart';

class DisplayTopicDialog extends StackedView<DisplayTopicDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DisplayTopicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  String cleanSummaryText(String inputText) {
    List<String> startRemove = ["اس میٹنگ میں", "آبوئسلی", "بیسکلی"];
    List<String> phrasesToRemove = [
      "کی گئی",
      "ہے۔",
      "ہے اور",
      " اور اس کے علاوہ",
      "کیا گیا",
      "کی گئی ہے",
      "گیا",
      "کیا گیا ہے",
      "گیا ہے"
    ];

    // Remove specified phrases and everything after "کیا گیا ہے"
    for (String phrase1 in startRemove) {
      inputText = inputText.replaceFirst(phrase1, "");
    }
    for (String phrase in phrasesToRemove) {
      int index = inputText.indexOf(phrase);
      if (index != -1) {
        inputText = inputText.substring(0, index);
      }
    }

    return inputText.trim();
  }

  @override
  Widget builder(
    BuildContext context,
    DisplayTopicDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceMassive,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TOPICS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: TextButton(
                    onPressed: () {
                      completer(DialogResponse(confirmed: true));
                    },
                    child: const Icon(
                      Icons.close,
                      color: kcsliderColor,
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            FutureBuilder<List<List<String>>>(
              future: viewModel.getSummariesFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No summaries available.');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.asMap().entries.map((entry) {
                      int segmentNumber = entry.key + 1;
                      List<String> summaryList = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   '$segmentNumber:',
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          ...summaryList.map((summary) {
                            String cleanedSummary = cleanSummaryText(summary);
                            return Padding(
                              padding: const EdgeInsets.only(left: 400),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$segmentNumber:',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  horizontalSpaceMedium,
                                  Text(
                                    cleanedSummary,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  DisplayTopicDialogModel viewModelBuilder(BuildContext context) =>
      DisplayTopicDialogModel();
}

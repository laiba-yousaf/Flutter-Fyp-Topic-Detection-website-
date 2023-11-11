import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/privacy_policy.dart';
import 'package:flutter_html/flutter_html.dart';

import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StackedView<PrivacyPolicyViewModel> {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrivacyPolicyViewModel viewModel,
    Widget? child,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 200),
        child: SizedBox(
          width: 800,
          child: Html(
            data: privacyPlocy,
            shrinkWrap: true,
          ),
          // child: const Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [

          //     Padding(
          //       padding: EdgeInsets.only(top: 100,left:500),
          //       child: Text(
          //         "Privacy Policy",
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize:25),
          //       ),
          //     ),
          //     verticalSpaceMedium,
          //     Padding(
          //       padding: EdgeInsets.only(left:100),
          //       child: Text("Welcome to Topic Detection System.We are dedicated to protecting your personal information and your right to privacy. \nIf you have any questions or concerns about our policy or practices, please contact us.",style: TextStyle(fontSize:17),),
          //     ),
          //     verticalSpaceMedium,
          //     Padding(
          //       padding: EdgeInsets.only(left: 100),
          //       child: Text(
          //         "Information We Collect:",
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize:18),
          //       ),
          //     ),
          //     Text(data)

          //   ],
          // ),
        ),
      ),
    );
  }

  @override
  PrivacyPolicyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrivacyPolicyViewModel();
}

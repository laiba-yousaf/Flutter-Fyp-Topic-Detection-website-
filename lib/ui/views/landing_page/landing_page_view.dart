import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_colors.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/views/aboutus/aboutus_view.dart';
import 'package:topicdetectionweb/ui/views/contactus/contactus_view.dart';
import 'package:topicdetectionweb/ui/views/landing_page/widgets/Introduction.dart';
import 'package:topicdetectionweb/ui/views/landing_page/widgets/feacture_desc.dart';
import 'package:topicdetectionweb/ui/views/landing_page/widgets/tickmark.dart';
import 'package:topicdetectionweb/ui/views/signin/signin_view.dart';
import 'package:topicdetectionweb/ui/widgets/common/button/button.dart';

import '../../common/app_strings.dart';
import 'landing_page_viewmodel.dart';

class LandingPageView extends StackedView<LandingPageViewModel> {
  const LandingPageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LandingPageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 191, 152, 202),
          leading: Image(
            image: AssetImage(logopic),
            //width: 150,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  viewModel.pagenavigate("home");
                },
                child: Text("Home",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: viewModel.name == "home"
                          ? kcpurpleColor
                          : kcVeryLightGrey,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  viewModel.pagenavigate("Aboutus");
                },
                child: Text("About us",
                    style: TextStyle(
                      fontSize: 17,
                      color: viewModel.name == "Aboutus"
                          ? kcpurpleColor
                          : kcVeryLightGrey,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                  onPressed: () {
                    viewModel.pagenavigate("contactus");
                  },
                  child: Text("Contact us",
                      style: TextStyle(
                        fontSize: 17,
                        color: viewModel.name == "contactus"
                            ? kcpurpleColor
                            : kcVeryLightGrey,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                  onPressed: () {
                    viewModel.navigateTOSignin();
                  },
                  child: Text("Login",
                      style: TextStyle(
                        fontSize: 17,
                        color: viewModel.name == "login"
                            ? kcpurpleColor
                            : kcVeryLightGrey,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200),
              child: TextButton(
                  onPressed: () {
                    viewModel.navigateSignup();
                    viewModel.pagenavigate("register");
                  },
                  child: Text("Register",
                      style: TextStyle(
                        fontSize: 17,
                        color: viewModel.name == "register"
                            ? kcpurpleColor
                            : kcVeryLightGrey,
                      ))),
            ),
          ],
        ),
        body: (() {
          if (viewModel.name == "Aboutus") {
            return const AboutusView();
          }
          if (viewModel.name == "contactus") {
            return const ContactusView();
          }
          if (viewModel.name == "login") {
            return const SigninView();
          }
          if (viewModel.name == "home") {
            return SingleChildScrollView(
                child: Column(children: [
              Stack(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Image(
                        image: AssetImage(backimg1),
                        width: 600,
                      )),
                  Positioned(
                      left: 700,
                      child: Image(
                        image: AssetImage(titleimg),
                        width: 600,
                        height: 600,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100, top: 170),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Topic Detection From ",
                                    style: TextStyle(fontSize: 40)),
                                verticalSpaceSmall,
                                const Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Text("Urdu Meeting ",
                                      style: TextStyle(fontSize: 40)),
                                ),
                                verticalSpaceMassive,
                                verticalSpaceMedium,
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(arrow),
                                      width: 100,
                                      height: 40,
                                    ),
                                    Button(
                                      textColor: kcVeryLightGrey,
                                      Color: kcPrimaryColor,
                                      height: screenHeight(context) * 0.06,
                                      width: quarterScreenWidth(context) * 0.5,
                                      title: "Get Started",
                                      onTap: () {
                                        viewModel.navigateTOSignin();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 250, top: 100),
                        child: Column(
                          children: [
                            const Text(
                              "Introduction",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            intro(),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Image(
                                image: AssetImage(backimg2),
                                width: 800,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 240),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                feature(),
                                verticalSpaceLarge,
                                verticalSpaceLarge,
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(benifits),
                                      width: 300,
                                    ),
                                    horizontalSpaceLarge,
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 90),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Benefits",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                            ),
                                          ),
                                          verticalSpaceMedium,
                                          Text(halfBeneifitHeading),
                                          verticalSpaceSmall,
                                          Text(fullBeneifitHeading),
                                          verticalSpaceSmall,
                                          const Text(
                                              "all at your fingertips.."),
                                          verticalSpaceMedium,
                                          benifit(benefit1, benefit2, benefit3,
                                              benefit4),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceLarge,
                      Container(
                        height: 100,
                        color: kcsliderColor,
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1000),
                                child: Column(
                                  children: [
                                    verticalSpaceMedium,
                                    const Text(
                                      "Contact with us",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    verticalSpaceSmall,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(linkdinicon),
                                          width: 20,
                                          height: 20,
                                          color: Colors.white,
                                        ),
                                        horizontalSpaceMedium,
                                        Image(
                                            image: AssetImage(githubicon),
                                            width: 20,
                                            height: 20,
                                            color: Colors.white),
                                        horizontalSpaceMedium,
                                        Image(
                                            image: AssetImage(twitter),
                                            width: 20,
                                            height: 20,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]));
          }
        })());
  }

  @override
  LandingPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LandingPageViewModel();
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/app_strings.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import 'package:topicdetectionweb/ui/widgets/common/slider/slider.dart';

import '../../common/app_colors.dart';
import '../../widgets/common/button/button.dart';
import '../../widgets/common/mytextfield/mytextfield.dart';
import 'widgets/googleButton.dart';
import 'signin_viewmodel.dart';

class SigninView extends StackedView<SigninViewModel> {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SigninViewModel viewModel,
    Widget? child,
  ) {
    bool isDesktopView = screenWidth(context) >= 768;
    return Scaffold(
      body: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    verticalSpaceLarge,

                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceLarge,
                    googleButton(context, googleicon, "Continue with google",
                        screenHeight(context) * 0.06, () {}),
                    verticalSpaceMedium,
                    const Text("or"),
                    verticalSpaceMedium,
                    Mytextfield(
                      title: "Email",
                      ctrl: viewModel.emailctrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                    ),
                    verticalSpaceSmall,
                    Mytextfield(
                      title: "Password",
                      ctrl: viewModel.passctrl,
                      suffix: GestureDetector(
                        onTap: () {
                          viewModel.togglePasswordVisibility();
                        },
                        child: Icon(
                          viewModel.obsecure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: kcPrimaryColor,
                        ),
                      ),
                      obscureText: viewModel.obsecure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    verticalSpaceSmall,
                    //Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 190.0),
                      child: TextButton(
                          onPressed: () {
                            viewModel.auth
                                .sendPasswordResetEmail(
                                    email: viewModel.emailctrl.text.toString())
                                .then((value) {
                              viewModel.toastService.toastmessage(
                                  "we have send you email to recover password,please check email");
                            }).onError((error, stackTrace) {
                              viewModel.toastService.toastmessage(error.toString());
                            });
                          },
                          child: const Text("Forgot Password?")),
                    ),
                    verticalSpaceLarge,
                    Button(
                        title: "Login",
                        onTap: () {
                          if (viewModel.formKey.currentState!.validate()) {
                            viewModel.setloadingvalue(true);

                            viewModel.auth
                                .signInWithEmailAndPassword(
                                    email: viewModel.emailctrl.text.toString(),
                                    password:
                                        viewModel.passctrl.text.toString())
                                .then((value) {
                              viewModel.setloadingvalue(false);
                              viewModel.toastService
                                  .toastmessage("Login Succsessfully");
                              viewModel.navigationHome();
                            }).onError((error, stackTrace) {
                              viewModel.setloadingvalue(false);
                              viewModel.toastService
                                  .toastmessage(error.toString());
                            });
                          }
                        }),

                    verticalSpaceSmall,
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            viewModel.navigation();
                          },
                          child: const Text("Create one"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isDesktopView) // Show the slider only for desktop views
            const Expanded(
              flex: 1,
              child: Column(
                children: [
                  Sliderwidget(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  SigninViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SigninViewModel();
}

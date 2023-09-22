import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/common/button/button.dart';
import '../../widgets/common/mytextfield/mytextfield.dart';
import '../../widgets/common/mytextfield/mytextfield_model.dart';
import '../../widgets/common/slider/slider.dart';
import 'signup_viewmodel.dart';

class SignupView extends StackedView<SignupViewModel> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupViewModel viewModel,
    Widget? child,
  ) {
    bool isDesktopView = screenWidth(context) >= 768;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                    const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceLarge,
                    Mytextfield(
                      title: "Name",
                      ctrl: viewModel.namectrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null; // Return null for no error
                      },
                    ),
                    verticalSpaceSmall,
                    Mytextfield(
                      title: "Email",
                      ctrl: viewModel.emailctrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        return null; // Return null for no error
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
                        return null; // Return null for no error
                      },
                    ),
                    verticalSpaceSmall,
                    Mytextfield(
                      title: "Confirm Password",
                      ctrl: viewModel.conpassctrl,
                      suffix: GestureDetector(
                        onTap: () {
                          viewModel.togglePasswordVisibility1();
                        },
                        child: Icon(
                          viewModel.obsecure1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: kcPrimaryColor,
                        ),
                      ),
                      obscureText: viewModel.obsecure1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm password is required";
                        }
                        return null; // Return null for no error
                      },
                    ),
                    verticalSpaceLarge,
                    Button(
                        title: "Sign up",
                        loading: viewModel.loading,
                        onTap: () {
                          //viewModel.navigateTOSignin();
                          if (viewModel.formKey.currentState!.validate()) {
                            viewModel.setloadingvalue(true);
                            viewModel.auth
                                .createUserWithEmailAndPassword(
                                    email: viewModel.emailctrl.text.toString(),
                                    password:
                                        viewModel.passctrl.text.toString())
                                .then((value) {
                              viewModel.setloadingvalue(false);
                              viewModel.toastService
                                  .toastmessage("Registered Sucsessfully");
                              viewModel.navigateTOSignin();
                            }).onError((error, stackTrace) {
                              viewModel.setloadingvalue(false);
                              viewModel.toastService
                                  .toastmessage(error.toString());
                            });
                          }
                        }),
                    verticalSpaceLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            viewModel.navigateTOSignin();
                          },
                          child: const Text("Sign in"),
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
  SignupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupViewModel();
}

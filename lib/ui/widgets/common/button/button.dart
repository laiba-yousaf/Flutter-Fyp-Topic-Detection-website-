import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import 'button_model.dart';

class Button extends StackedView<ButtonModel> {
  final String? title;
  final VoidCallback? onTap;
  final bool loading;
  const Button({super.key, this.title, this.onTap,this.loading=false});

  @override
  Widget builder(
    BuildContext context,
    ButtonModel viewModel,
    Widget? child,
  ) {
    double textFieldWidth = screenWidth(context) >= 768
        ? quarterScreenWidth(context) * 0.5
        : halfScreenWidth(context) * 1.6;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: screenHeight(context) * 0.06,
        width: textFieldWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: kcPrimaryColor,
        ),
        child: Center(
          child:loading? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :Text(
            title!,
            style: const TextStyle(color: Color.fromARGB(255, 253, 251, 251)),
          ),
        ),
      ),
    );
  }

  @override
  ButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      ButtonModel();
}

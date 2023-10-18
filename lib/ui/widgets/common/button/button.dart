import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import 'button_model.dart';

class Button extends StackedView<ButtonModel> {
  final String? title;
  final VoidCallback? onTap;
  final bool loading;
  final double width;
  final double height;
  final Color;
   final textColor;
  const Button( {
    super.key,
    this.title,
    this.onTap,
    this.loading = false,
    required this.textColor,
    required this.Color,
    required this.width,
    required this.height,

  });

  @override
  Widget builder(
    BuildContext context,
    ButtonModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color,
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title!,
                  style:  TextStyle(
                      fontSize: 14, color:textColor,
                      ),
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

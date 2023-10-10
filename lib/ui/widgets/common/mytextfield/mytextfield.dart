import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';

import 'mytextfield_model.dart';

class Mytextfield extends StackedView<MytextfieldModel> {
  final TextEditingController? ctrl;
  final String? title;
  final Widget? suffix;
  final bool? obscureText;
  final int? maxlines;
  final bool? maxcond;
  final Widget? prefix;
  final FormFieldValidator<String>? validator;

  const Mytextfield(
      {Key? key,
      this.title,
      this.ctrl,
      this.suffix,
      this.obscureText,
      this.maxcond,
      this.maxlines,
      this.validator,
      this.prefix})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MytextfieldModel viewModel,
    Widget? child,
  ) {
    double hintFontSize =
        MediaQuery.of(context).size.width >= 768 ? 14.0 : 12.0;
    double textFieldWidth = MediaQuery.of(context).size.width >= 768
        ? quarterScreenWidth(context)
        : halfScreenWidth(context) * 1.6;
    return SizedBox(
      width: textFieldWidth,
      child: TextFormField(
        maxLines: maxcond != null && maxcond! ? maxlines : 1,
        controller: ctrl,
        // expands: false,

        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            hintText: title,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            hintStyle: TextStyle(fontSize: hintFontSize),
            suffixIcon: suffix,
            prefixIcon: prefix),
        validator: validator,
      ),
    );
  }

  @override
  MytextfieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      MytextfieldModel();
}

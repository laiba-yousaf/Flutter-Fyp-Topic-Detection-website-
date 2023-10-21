import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import '../../../common/app_strings.dart';
import '../aboutus_viewmodel.dart';

class Cardwidget extends ViewModelWidget<AboutusViewModel> {
  final String pic;
  final String name;
  final String description;

  const Cardwidget({
    Key? key,
    required this.pic,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    AboutusViewModel viewModel,
  ) {
    final hoverNotifier = ValueNotifier<bool>(false);

    return MouseRegion(
      onEnter: (_) {
        hoverNotifier.value = true;
      },
      onExit: (_) {
        hoverNotifier.value = false;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: hoverNotifier,
        builder: (context, isHovered, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              0,
              0,
              isHovered ? -50 : 0,
            ),
            decoration: BoxDecoration(
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: SizedBox(
              width: 250,
              height: 300,
              child: Card(
                color: isHovered
                    ? Color.fromARGB(255, 241, 240, 240)
                    : Colors.white,
                elevation: 3,
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: AssetImage(pic),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Text(name),
                    verticalSpaceSmall,
                    Text(description),
                    verticalSpaceLarge,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(twitter),
                          width: 20,
                          height: 20,
                        ),
                        horizontalSpaceSmall,
                        Image(
                          image: AssetImage(linkdinicon),
                          width: 20,
                          height: 20,
                        ),
                        horizontalSpaceSmall,
                        Image(
                          image: AssetImage(githubicon),
                          width: 20,
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

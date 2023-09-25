import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:topicdetectionweb/ui/common/ui_helpers.dart';
import '../../../common/app_strings.dart';
import 'slider_model.dart';

class Sliderwidget extends StackedView<SliderModel> {
  const Sliderwidget({super.key});

  @override
  Widget builder(
    BuildContext context,
    SliderModel viewModel,
    Widget? child,
  ) {
    return Column(
      children: [
        verticalSpaceMassive,
        Stack(children: [
          CarouselSlider(
            items: [
              Container(
                height: screenHeight(context),
                child: Image(image: AssetImage(image1),)),
              Image(image: AssetImage(image2)),
              Image(image: AssetImage(image3)),
            ],
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              autoPlay: true,
              // Dots indicator upper show hoga
              onPageChanged: (index, reason) {
                viewModel.updateindex(index);
              },
            ),
          ),
          verticalSpaceLarge,
          Positioned(
            top: 350,
            left: 200,
            //bottom: 50,

            child: Container(
              width: 80,
              height: 25,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 41, 40, 40).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: viewModel.currentCarouselIndex == i
                            ? const Color.fromARGB(
                                255, 172, 116, 245) // Set the active dot color
                            : const Color.fromARGB(255, 241, 236, 236),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }

  @override
  SliderModel viewModelBuilder(
    BuildContext context,
  ) =>
      SliderModel();
}

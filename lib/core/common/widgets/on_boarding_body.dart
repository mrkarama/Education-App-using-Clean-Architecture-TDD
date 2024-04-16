import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/extensions/context_extensions.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    required this.pageContent,
    super.key,
  });

  final PageContent pageContent;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * .4,
        ),
        SizedBox(
          height: context.height * .05,
        ),
        Padding(
          padding: EdgeInsets.all(context.height * .04).copyWith(
            bottom: 0,
            top: 0,
          ),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontSize: Dimensions.responsiveDimension(19.16, context),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: context.height * .03,
              ),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimensions.responsiveDimension(47.33, context),
                ),
              ),
              SizedBox(
                height: context.height * .05,
              ),
              RoundedButton(
                label: 'Get Started',
                buttonWidth: Dimensions.responsiveDimension(4, context),
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

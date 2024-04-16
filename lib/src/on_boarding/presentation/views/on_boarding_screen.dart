import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/on_boarding_body.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/dimensions.dart';
import 'package:education_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // In case the image takes time to load
      body: SafeArea(
        child: GradientBackground(
          image: MediaRes.onBoardingBackground,
          child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
            listener: (context, state) {
              if (state is UserCached) {
                Navigator.pushReplacementNamed(context, '/');
              } else if (state is OnBoardingStatus && state.isFirstTimer) {
                //
              }
            },
            builder: (context, state) {
              if (state is CachingFirstTimer ||
                  state is CheckIfUserIsFirstTimer) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  PageView(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      OnBoardingBody(
                        pageContent: PageContent.first(),
                      ),
                      OnBoardingBody(
                        pageContent: PageContent.second(),
                      ),
                      OnBoardingBody(
                        pageContent: PageContent.third(),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(
                      0,
                      0.06,
                    ),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      onDotClicked: (index) => pageController.animateToPage(
                        index,
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      effect: WormEffect(
                        dotHeight:
                            Dimensions.responsiveDimension(57.47, context),
                        dotWidth:
                            Dimensions.responsiveDimension(57.47, context),
                        activeDotColor: XColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

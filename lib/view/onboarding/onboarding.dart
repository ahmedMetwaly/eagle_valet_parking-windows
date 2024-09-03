import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../generated/l10n.dart';
import '../../../resources/routes.dart';
import '../../../resources/string_manager.dart';
import '../../repositiries/shared_prefrences/sharedprefrences_service.dart';
import '../../resources/image_manager.dart';
import '../../resources/values_manager.dart';
import 'widgets/onboarding_button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
//TODO:: change the titles and images from assets
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        title: S.current.onboarding1Title,
        body: S.current.onboarding1Body,
        image: Image.asset(ImageManager.onboarding1),
      ),
      PageViewModel(
        title: StringManager.onboarding2Title,
        body: StringManager.onboarding2Body,
        image: Image.asset(ImageManager.onboarding2),
      ),
      PageViewModel(
        title: StringManager.onboarding3Title,
        body: StringManager.onboarding3Body,
        image: Image.asset(ImageManager.onboarding3),
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          bodyPadding: const EdgeInsets.all(PaddingManager.pMainPadding),
          showSkipButton: true,
          curve: Curves.bounceInOut,
          onSkip: () async {
            await SharedPrefrencesService.addBoolToSF("isOpenedBefore", true)
                .then((value) {
              Navigator.of(context).pushReplacementNamed(Routes.logIn);
            });
          },
          onDone: () async {
            await SharedPrefrencesService.addBoolToSF("isOpenedBefore", true) .then((value) {
              Navigator.of(context).pushReplacementNamed(Routes.logIn);
            });
          },
          skip: OnBoardingButton(title: S.current.skip),
          next: const Icon(Icons.arrow_forward),
          done: OnBoardingButton(title: S.current.done),
          pages: pages,
        ),
      ),
    );
  }
}

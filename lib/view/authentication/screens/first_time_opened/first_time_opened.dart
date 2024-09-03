import "package:flutter/material.dart";
import "../../../../../generated/l10n.dart";
import "../../../../../resources/values_manager.dart";
import "../../../../resources/image_manager.dart";
import "widgets/select_language.dart";

class AppStarts extends StatelessWidget {
  const AppStarts({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImageManager.splash, 
            height: size.height *0.25,
            width: size.width * 0.25,
            ),
            const SizedBox(height: SizeManager.sSpace16),
            Text(
              S.current.selectLanguage,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: SizeManager.sSpace),
            const MyToggleButtons(),
          ]),
    );
  }
}

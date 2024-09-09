
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.05,
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: Text(
          S.current.copyRight,
          style:
              TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import 'live_preview_content.dart';

class ShowTodayCollection extends StatefulWidget {
  const ShowTodayCollection({super.key, required this.todayCollection});
  final String todayCollection;
  @override
  State<ShowTodayCollection> createState() => _ShowTodayCollectionState();
}

class _ShowTodayCollectionState extends State<ShowTodayCollection> {
  bool showCollection = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LivePrevewContent(
          value: showCollection
              ? "${widget.todayCollection} ${S.current.currencySign}"
              : "******",
          description: S.current.todaysCollection,
        ),
        IconButton.filled(
            onPressed: () {
              setState(() {
                //printshowCollection);
                showCollection = !showCollection;
                //printshowCollection);
                Future.delayed(const Duration(seconds: 5)).then((value) {
                  setState(() {
                    showCollection = false;
                    //printshowCollection);
                  });
                });
              });
            },
            icon: Icon(
              showCollection
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: Theme.of(context).colorScheme.surface,
            ))
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gpt/screens/search_precision_screen.dart';
import 'package:gpt/screens/search_sans_precision_screen.dart';

import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/typography.dart';

class SearchScreen extends StatefulWidget {
  final UserModel userModel;

  const SearchScreen({super.key, required this.userModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int? _sliding = 0;

  @override
  Widget build(BuildContext context) {
    List body = [
      SearchPrecisionScreen(userModel: widget.userModel),
      SearchSansPrecisionScreen(userModel: widget.userModel)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: TypoText(
                text: AppLocalizations.of(context)!.search,
                color: AppColors.colorTextInput)
            .large(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                  height: 5,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.red)),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSlidingSegmentedControl(
                  thumbColor: AppColors.backgroundButton,
                  children: {
                    0: TypoText(
                            text: AppLocalizations.of(context)!.precision,
                            color: _sliding == 0
                                ? AppColors.colorTextWhite
                                : AppColors.colorTextInput)
                        .long(),
                    1: TypoText(
                            text: AppLocalizations.of(context)!.with_precision,
                            color: _sliding == 1
                                ? AppColors.colorTextWhite
                                : AppColors.colorTextInput)
                        .long(),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      _sliding = value;
                    });
                  },
                  groupValue: _sliding,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Flexible(child: body.elementAt(_sliding!))
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 5,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.red),
        ),
      ),
    );
  }
}

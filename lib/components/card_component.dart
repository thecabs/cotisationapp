import 'package:flutter/material.dart';
import 'package:gpt/components/chip_component.dart';
import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/utils/app_colors.dart';

import '../utils/typography.dart';

class CardComponent extends StatelessWidget {
  final CotisationModel cotisationModel;
  CardComponent({super.key, required this.cotisationModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 1.5),
      child: Card(
        surfaceTintColor: AppColors.background2,
        color: AppColors.background2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              dense: true,
              leading: CircleAvatar(
                backgroundColor: AppColors.backgroundButton,
                child: TypoText(
                        text: cotisationModel.nom[0].toString(),
                        color: AppColors.colorTextWhite)
                    .h1(),
              ),
              title: TypoText(
                      text: cotisationModel.nom,
                      color: AppColors.colorTextInput)
                  .h3(),
              subtitle: TypoText(
                      text: cotisationModel.montant.toString(),
                      color: AppColors.colorTextInput)
                  .longCast(),
            ),
            Divider(
              indent: 16.0,
              endIndent: 16.0,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChipComponent(
                      iconData: Icons.calendar_month,
                      text: TypoText(
                              text: cotisationModel.date,
                              color: AppColors.colorTextInput)
                          .longCast(),
                    ),
                    ChipComponent(
                      iconData: Icons.schedule,
                      text: TypoText(
                              text: cotisationModel.heure,
                              color: AppColors.colorTextInput)
                          .longCast(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

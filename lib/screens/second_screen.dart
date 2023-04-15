import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gpt/models/bank_model.dart';
import 'package:gpt/screens/authentication_screen.dart';
import 'package:gpt/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';

import '../components/button_component.dart';
import '../utils/typography.dart';

class SecondScreen extends StatefulWidget {
  final BankModel bankModel;
  final String endpoint;
  const SecondScreen(
      {super.key, required this.bankModel, required this.endpoint});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    
    var url =
        "https://${widget.endpoint}/api/logo/${widget.bankModel.lienLogo}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.colorTextInput,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: TypoText(
                            text: "${widget.bankModel.libelle}",
                            color: AppColors.colorTextInput)
                        .large(),
                  ),
                  TypoText(
                          text: AppLocalizations.of(context)!.validate_bank,
                          color: AppColors.colorTextLong)
                      .long(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: url,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 90,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        print(error.toString());
                        return Center(child: Icon(Icons.error));
                      },
                    ),
                  )
                ],
              ),
            ),
            ButtonComponent(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => AuthenticationScreen()),
                  (route) => false),
              color: AppColors.backgroundButton,
              child: TypoText(
                      text: AppLocalizations.of(context)!.validate,
                      color: AppColors.colorTextWhite)
                  .h2(),
            )
          ],
        ),
      ),
    );
  }
}

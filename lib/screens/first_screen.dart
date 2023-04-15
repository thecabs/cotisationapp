// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/models/user_model.dart';
import 'package:gpt/screens/authentication_screen.dart';
import 'package:gpt/screens/second_screen.dart';
import 'package:gpt/utils/app_colors.dart';
import 'package:gpt/utils/typography.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/first_screen/first_screen_bloc.dart';
import '../components/button_component.dart';
import 'main_screen.dart';

class FirstScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final serveurController = TextEditingController();
  final banqueController = TextEditingController();
  late SharedPreferences sharedPreferences;

  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FirstScreenBloc()..add(const FirstScreenCheckEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
        ),
        body: BlocConsumer<FirstScreenBloc, FirstScreenState>(
          listener: (context, state) {
            if (state is FirstScreenGoAuthenticationState) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => AuthenticationScreen()),
                  (route) => false);
            }
            if (state is FirstScreenGoMainScreenState) {
              UserModel userModel = UserModel(
                  id: state.id,
                  banqueId: null,
                  username: state.username,
                  nom: state.nom,
                  mobile: null,
                  password: null,
                  adresse: state.adresse,
                  type: null,
                  actif: null,
                  idAgence: state.idAgence,
                  idZone: state.idZone,
                  code: state.code,
                  );
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainScreen(userModel: userModel)),
                  (route) => false);
            }

            if (state is FirstScreenSuccess) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SecondScreen(
                      bankModel: state.bankModel,
                      endpoint: serveurController.text.trim())));
            }

            if (state is FirstScreenErrorState) {
              hideSnackBar(context);
              showSnackBar(
                  context, AppLocalizations.of(context)!.not_found_bank, 2);
            }
          },
          builder: (context, state) {
            return Padding(
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
                                    text: AppLocalizations.of(context)!
                                        .welcome_app,
                                    color: AppColors.colorTextInput)
                                .large(),
                          ),
                          TypoText(
                                  text: AppLocalizations.of(context)!
                                      .welcome_more_app,
                                  color: AppColors.colorTextLong)
                              .long(),
                          const SizedBox(height: 20.0),
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: serveurController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.inter(
                                      color: AppColors.colorTextInput,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: AppColors.colorTextInput,
                                  keyboardType: TextInputType.url,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(color: AppColors.red),
                                    filled: true,
                                    fillColor: AppColors.background2,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: BorderSide.none),
                                    hintText:
                                        AppLocalizations.of(context)!.server,
                                    hintStyle: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .empty_input;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                TextFormField(
                                  controller: banqueController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.inter(
                                      color: AppColors.colorTextInput,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: AppColors.colorTextInput,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(color: AppColors.red),
                                    filled: true,
                                    fillColor: AppColors.background2,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: BorderSide.none),
                                    hintText:
                                        AppLocalizations.of(context)!.id_banque,
                                    hintStyle: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .empty_input;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                ButtonComponent(
                                  onPressed: (state
                                          is FirstScreenWaitingSubmitData)
                                      ? () {}
                                      : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            context.read<FirstScreenBloc>().add(
                                                FirstScreenSubmitDataEvent(
                                                    serverAdress:
                                                        serveurController.text
                                                            .trim(),
                                                    banqueId: banqueController
                                                        .text
                                                        .trim()));
                                          }
                                        },
                                  color: AppColors.backgroundButton,
                                  child: TypoText(
                                          text:
                                              (state is FirstScreenWaitingSubmitData)
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .loading
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .test,
                                          color: AppColors.colorTextWhite)
                                      .h2(),
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  hideSnackBar(BuildContext context) => ScaffoldMessenger.of(context)
      .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);

  showSnackBar(BuildContext context, String text, int duration) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.backgroundButton,
          duration: Duration(seconds: duration),
          content: TypoText(text: text, color: Colors.white).h3()));
}

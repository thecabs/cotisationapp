import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/components/button_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gpt/models/client_model.dart';
import 'package:gpt/models/cotisation_model.dart';
import 'package:gpt/utils/custom_date.dart';
import 'package:gpt/utils/typography.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/cotisation/cotisation_bloc.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';
import 'authentication_screen.dart';

// ignore: must_be_immutable
class CotisationScreen extends StatelessWidget {
  final UserModel userModel;

  // form key for search client
  final formKeyCompte = GlobalKey<FormState>();
  final telephoneController = TextEditingController();
  var idClient;
  var idAgence;
  var code;
  var attemps = 3;
  var enable = true;
  // form key for client's cotisation
  final formKeyCotisation = GlobalKey<FormState>();
  final numCompteClientController = TextEditingController();
  final nomClientController = TextEditingController();
  final montantClientController = TextEditingController();
  final numeroClientController = TextEditingController();
  final confirmMontantClientController = TextEditingController();
  final userCodeController = TextEditingController();

  CotisationScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    _showInformations() async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: TypoText(
                      text: AppLocalizations.of(context)!.information,
                      color: AppColors.colorTextInput)
                  .h2(),
              backgroundColor: AppColors.background,
              surfaceTintColor: AppColors.background,
              content: SizedBox(
                height: 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.backgroundButton,
                        child: TypoText(
                                text: userModel.nom.toString()[0],
                                color: AppColors.colorTextWhite)
                            .large(),
                      ),
                      title: TypoText(
                              text: userModel.nom.toString(),
                              color: AppColors.colorTextInput)
                          .longCast(),
                      subtitle: TypoText(
                              text: userModel.id.toString(),
                              color: AppColors.colorTextInput)
                          .short(),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      var instance = await SharedPreferences.getInstance();

                      instance.setBool("login", false);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => AuthenticationScreen()),
                          (route) => false);
                    },
                    child: TypoText(
                            text: AppLocalizations.of(context)!.logout,
                            color: AppColors.red)
                        .long())
              ],
            );
          });
    }

    _showInformations2() async {
      var msg =
          AppLocalizations.of(context)!.attemps + ' ' + attemps.toString();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: TypoText(
                      text: AppLocalizations.of(context)!.information,
                      color: AppColors.colorTextInput)
                  .h2(),
              backgroundColor: AppColors.background,
              surfaceTintColor: AppColors.background,
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  Text(msg),
                ],
              )),
              actions: <Widget>[
                TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text("OK"))
              ],
            );
          });
    }

    clearFields() {
      telephoneController.clear();
      montantClientController.clear();
      confirmMontantClientController.clear();
    }

    clearFieldsSimple() {
      numCompteClientController.clear();
      nomClientController.clear();
      numeroClientController.clear();
      userCodeController.clear();
    }

    fillFields({required ClientModel clientModel}) {
      numCompteClientController.text = clientModel.numCompte.toString();
      nomClientController.text = clientModel.nom.toString();
      numeroClientController.text = clientModel.mobile;
      idClient = clientModel.id.toString();
      idAgence = clientModel.idAgence.toString();

      print(idAgence);
      print(idClient);
      print(numCompteClientController.text);
    }

    return BlocProvider(
      create: (context) => CotisationBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: TypoText(
                  text: AppLocalizations.of(context)!.cotisation,
                  color: AppColors.colorTextInput)
              .large(),
          actions: [
            GestureDetector(
              onTap: () => _showInformations(),
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundButton,
                child: TypoText(
                        text: userModel.nom.toString()[0],
                        color: AppColors.colorTextWhite)
                    .large(),
              ),
            ),
            SizedBox(width: 16.0)
          ],
        ),
        body: BlocConsumer<CotisationBloc, CotisationState>(
          listener: (context, state) {
            // state for search
            if (state is CotisationSearchErrorState) {
              clearFieldsSimple();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.backgroundButton,
                  content: TypoText(
                          text: AppLocalizations.of(context)!.client_not_found,
                          color: Colors.white)
                      .h3()));
            }

            if (state is CotisationWaitingSearchState) {
              // code for waiting
              // ignore: avoid_print
              print("waiting");
            }

            if (state is CotisationSearchState) {
              fillFields(clientModel: state.clientModel);
            }

            // state for cotisation
            if (state is CotisationWaitingSave) {
              // ignore: avoid_print
              print("waiting");
            }

            if (state is CotisationSave) {
              clearFields();
              clearFieldsSimple();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.backgroundButton,
                  content: TypoText(
                          text:
                              AppLocalizations.of(context)!.cotisation_success,
                          color: Colors.white)
                      .h3()));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                        height: 5,
                        width: double.infinity,
                        decoration: BoxDecoration(color: AppColors.red)),
                    SizedBox(height: 20.0),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKeyCompte,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TypoText(
                                  text: AppLocalizations.of(context)!.acc_more,
                                  color: AppColors.colorTextInput)
                              .long(),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: telephoneController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.inter(
                                      color: AppColors.colorTextInput,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: AppColors.colorTextInput,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(color: AppColors.red),
                                    filled: true,
                                    fillColor: AppColors.background2,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: BorderSide.none),
                                    hintText:
                                        AppLocalizations.of(context)!.phone,
                                    hintStyle: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .empty_input;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              // ignore: deprecated_member_use
                              ButtonComponent(
                                onPressed: () {
                                  if (formKeyCompte.currentState!.validate()) {
                                    BlocProvider.of<CotisationBloc>(context)
                                        .add(CotisationOnSearchEvent(
                                            numCompte: telephoneController.text,
                                            code: userModel.idZone.toString(),
                                            idAgence:
                                                userModel.idAgence.toString()));
                                  }
                                },
                                color: AppColors.backgroundButton,
                                // ignore: deprecated_member_use
                                child: const Icon(Icons.search),
                              ),
                              const SizedBox(width: 12.0),
                              // ignore: deprecated_member_use
                              ButtonComponent(
                                onPressed: () {
                                  clearFields();
                                  clearFieldsSimple();
                                },
                                color: AppColors.backgroundButton,
                                // ignore: deprecated_member_use
                                child: const Icon(Icons.refresh),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Form(
                      key: formKeyCotisation,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(children: [
                            Flexible(
                              flex: 4,
                              child: TextFormField(
                                readOnly: true,
                                controller: numCompteClientController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: GoogleFonts.inter(
                                    color: AppColors.colorTextInput,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                cursorColor: AppColors.colorTextInput,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: AppColors.red),
                                  filled: true,
                                  fillColor: AppColors.background2,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none),
                                  hintText:
                                      AppLocalizations.of(context)!.acc_number,
                                  hintStyle: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .empty_input;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Flexible(
                              flex: 2,
                              child: TextFormField(
                                controller: userCodeController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: GoogleFonts.inter(
                                    color: AppColors.colorTextInput,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                cursorColor: AppColors.colorTextInput,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: AppColors.red),
                                  filled: true,
                                  fillColor: AppColors.background2,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      borderSide: BorderSide.none),
                                  hintText: 'code',
                                  hintStyle: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .empty_input;
                                  }
                                  /*else if(value.compareTo(userModel.code.toString())==0){
                                      attemps=attemps-1;
                                      if(attemps>0){
                                      return AppLocalizations.of(context)!
                                          .attemps +' '+ attemps.toString();
                                          }
                                          else{
                                            
                                          }    
                                    }*/
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 4.0),
                          ]),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            readOnly: true,
                            controller: nomClientController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: GoogleFonts.inter(
                                color: AppColors.colorTextInput,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                            cursorColor: AppColors.colorTextInput,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: AppColors.red),
                              filled: true,
                              fillColor: AppColors.background2,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none),
                              hintText: AppLocalizations.of(context)!.name,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: montantClientController,
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
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none),
                              hintText: AppLocalizations.of(context)!.amount,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              } else if (int.parse(value) < 500) {
                                return AppLocalizations.of(context)!
                                    .amount_error;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: confirmMontantClientController,
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
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none),
                              hintText:
                                  AppLocalizations.of(context)!.confirm_amount,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }
                              if (montantClientController.text.trim() !=
                                  confirmMontantClientController.text.trim()) {
                                return AppLocalizations.of(context)!
                                    .check_amount;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          ButtonComponent(
                            onPressed: enable
                                ? () async {
                                    //*****
                                    enable = false;
                                    var code2 = userCodeController.text.trim();
                                    if (code2 == userModel.code) {
                                      attemps = 3;
                                      if (formKeyCotisation.currentState!
                                          .validate()) {
                                        final cotisationModel = CotisationModel(
                                            montant: int.tryParse(
                                                montantClientController.text
                                                    .trim())!,
                                            date: CustomDate.now(),
                                            heure: CustomDate.hour(),
                                            idAgence: int.parse(idAgence),
                                            idClient:
                                                int.tryParse(idClient.trim())!,
                                            idUser: userModel.id!,
                                            mobile: numeroClientController.text
                                                .trim(),
                                            numCompte: numCompteClientController
                                                .text
                                                .trim(),
                                            nom: nomClientController.text
                                                .trim());

                                        BlocProvider.of<CotisationBloc>(context)
                                            .add(CotisationOnSaveEvent(
                                                cotisationModel:
                                                    cotisationModel));
                                      }
                                    } else {
                                      attemps = attemps - 1;
                                      if (attemps > 0) {
                                        _showInformations2();
                                      } else {
                                        var instance = await SharedPreferences
                                            .getInstance();
                                        instance.setBool("login", false);
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AuthenticationScreen()),
                                                (route) => false);
                                      }
                                      //==============
                                    }
                                    enable = true;
                                  }
                                : null,
                            color: AppColors.backgroundButton,
                            child: TypoText(
                                    text: (state is CotisationWaitingSave ||
                                            state
                                                is CotisationWaitingSearchState)
                                        ? AppLocalizations.of(context)!.loading
                                        : AppLocalizations.of(context)!
                                            .validate,
                                    color: AppColors.colorTextWhite)
                                .h2(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.red),
          ),
        ),
      ),
    );
  }
}

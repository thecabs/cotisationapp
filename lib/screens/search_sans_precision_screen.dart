import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/models/user_model.dart';
import 'package:gpt/screens/search_list_screen.dart';
import 'package:gpt/utils/app_colors.dart';
import 'package:gpt/utils/custom_date.dart';
import 'package:gpt/utils/typography.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/recherche/recherche_bloc.dart';
import '../components/button_component.dart';

class SearchSansPrecisionScreen extends StatelessWidget {
  final UserModel userModel;
  final firstDateController = TextEditingController();
  final secondDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SearchSansPrecisionScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    clearFields() {
      firstDateController.clear();
      secondDateController.clear();
    }

    return BlocProvider(
      create: (context) => RechercheBloc()..add(RechercheInitialEvent()),
      child: Scaffold(
        body: BlocConsumer<RechercheBloc, RechercheState>(
          listener: (context, state) {
            if (state is RechercheInitial) {
              clearFields();
            }

            if (state is RechercheSelectFirstDateState) {
              firstDateController.text = CustomDate.custom(state.date);
            }

            if (state is RechercheSelectSecondDateState) {
              secondDateController.text = CustomDate.custom(state.date);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TypoText(
                            text: AppLocalizations.of(context)!.search_more,
                            color: AppColors.colorTextLong)
                        .long(),
                    const SizedBox(height: 16.0),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                    readOnly: true,
                                    controller: firstDateController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: GoogleFonts.inter(
                                        color: AppColors.colorTextInput,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: AppColors.colorTextInput,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          color: AppColors.red),
                                      filled: true,
                                      fillColor: AppColors.background2,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none),
                                      hintText: AppLocalizations.of(context)!
                                          .first_date,
                                      hintStyle: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(3000));

                                      /// check if date isn't null
                                      if (pickedDate != null) {
                                        // ignore: use_build_context_synchronously
                                        BlocProvider.of<RechercheBloc>(context)
                                            .add(RechercheSelectFirstDateEvent(
                                                date: pickedDate));
                                      }
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .empty_input;
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(width: 16.0),
                              Flexible(
                                child: TextFormField(
                                    readOnly: true,
                                    controller: secondDateController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: GoogleFonts.inter(
                                        color: AppColors.colorTextInput,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: AppColors.colorTextSecondary,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(
                                          color: AppColors.red),
                                      filled: true,
                                      fillColor: AppColors.background2,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none),
                                      hintText: AppLocalizations.of(context)!
                                          .second_date,
                                      hintStyle: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(3000));

                                      /// check if date isn't null
                                      if (pickedDate != null) {
                                        // ignore: use_build_context_synchronously
                                        BlocProvider.of<RechercheBloc>(context)
                                            .add(RechercheSelectSecondDateEvent(
                                                date: pickedDate));
                                      }
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .empty_input;
                                      }
                                      return null;
                                    }),
                              )
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          ButtonComponent(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SearchListScreen(
                                      date1:
                                          firstDateController.text.toString(),
                                      date2:
                                          secondDateController.text.toString(),
                                      numCompte: null,
                                      idUser: userModel.id.toString(),
                                    ),
                                  ),
                                );
                              }
                            },
                            color: AppColors.backgroundButton,
                            child: TypoText(
                                    text: AppLocalizations.of(context)!.search,
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
      ),
    );
  }
}

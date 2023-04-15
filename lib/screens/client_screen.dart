import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/client/client_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/components/button_component.dart';
import 'package:gpt/models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/custom_date.dart';
import '../utils/typography.dart';

class AddClientView extends StatelessWidget {
  final UserModel userModel;
  AddClientView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddClientBloc(),
      // providers: [
      //   BlocProvider<AddClientBloc>(create: (context) => AddClientBloc()),
      // ],
      child: ClientScreen(),
    );
  }
}

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final formKey = GlobalKey<FormState>();
  final formKeyDoc = GlobalKey<FormState>();
  final formKeyClient = GlobalKey<FormState>();

  // controllers client
  final mobilecontroller = TextEditingController();
  final cmobilecontroller = TextEditingController();
  final nomController = TextEditingController();
  final firstDateNController = TextEditingController();
  final secondDateNController = TextEditingController();
  final lieuNController = TextEditingController();

  String selectedGenretype = 'F';

  String selectedLangtype = 'Fr';

  // controllers cni
  final ncniController = TextEditingController();
  final cncniController = TextEditingController();
  final firstDateCNIController = TextEditingController();
  final secondDateCNIController = TextEditingController();
  final lieuCNIController = TextEditingController();
  final professionController = TextEditingController();
  var addclientBloc;

  // verification of fields
  bool mobileConfirmed() {
    if (mobilecontroller.text.trim() == cmobilecontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool dateNConfirmed() {
    if (firstDateNController.text.trim() == secondDateNController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool dateCNIConfirmed() {
    if (firstDateCNIController.text.trim() ==
        secondDateCNIController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future nextstep() async {
    if (mobileConfirmed() == true) {
      if (dateNConfirmed() == true) {}
    } else {
      mobilecontroller.clear();
      cmobilecontroller.clear();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.background,
              content: TypoText(
                      text: AppLocalizations.of(context)!.authentication_error,
                      color: AppColors.colorTextInput)
                  .longCast(),
            );
          });
    }
  }

  Future validate() async {}

  // configuration stepper
  int currentStep = 0;

  onStepContinue() async {
    if (currentStep < 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  onStepCancel() async {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  onStepTapped(int value) async {
    setState(() {
      currentStep = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    clearFields() {
      mobilecontroller.clear();
      cmobilecontroller.clear();
      nomController.clear();
      firstDateNController.clear();
      secondDateNController.clear();
      lieuNController.clear();
      ncniController.clear();
      cncniController.clear();
      firstDateCNIController.clear();
      secondDateCNIController.clear();
      lieuCNIController.clear();
      professionController.clear();
    }

    return BlocProvider(
      create: (BuildContext context) => AddClientBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: TypoText(
                  text: AppLocalizations.of(context)!.client,
                  color: AppColors.colorTextInput)
              .large(),
        ),
        body: BlocConsumer<AddClientBloc, AddClientState>(
            listener: (context, state) {
          if (state is AddClientInitial) {
            clearFields();
          }

          if (state is AddClientSelectFirstDateNState) {
            firstDateNController.text = CustomDate.custom(state.date);
          }

          if (state is AddClientSelectSecondDateNState) {
            secondDateNController.text = CustomDate.custom(state.date);
          }
          if (state is AddClientSelectSecondDateCNIState) {
            secondDateCNIController.text = CustomDate.custom(state.date1);
          }
          if (state is AddClientSelectFirstDateCNIState) {
            firstDateCNIController.text = CustomDate.custom(state.date1);
          }
        }, builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.red)),
              ),
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: onStepContinue,
                  onStepCancel: onStepCancel,
                  onStepTapped: onStepTapped,
                  controlsBuilder: controlsBuilder,
                  elevation: 0,
                  steps: [
                    Step(
                        title: TypoText(
                                text: AppLocalizations.of(context)!.step + " 1",
                                color: AppColors.colorTextInput)
                            .longCast(),
                        subtitle: TypoText(
                                text: AppLocalizations.of(context)!.info_client,
                                color: AppColors.colorTextInput)
                            .longCast(),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Form(
                                key: formKeyClient,
                                child: Column(
                                  children: [
                                    SizedBox(height: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller: mobilecontroller,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: AppColors.red),
                                              filled: true,
                                              fillColor: AppColors.background2,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  borderSide: BorderSide.none),
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .phone,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .phone,
                                              labelStyle: GoogleFonts.inter(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          child: TextFormField(
                                            controller: cmobilecontroller,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: AppColors.red),
                                                filled: true,
                                                fillColor:
                                                    AppColors.background2,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    borderSide:
                                                        BorderSide.none),
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .phone,
                                                hintStyle: GoogleFonts.inter(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                labelText:
                                                    AppLocalizations.of(context)!
                                                        .phone,
                                                labelStyle: GoogleFonts.inter(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    TextFormField(
                                      controller: nomController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      cursorColor: AppColors.colorTextInput,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: AppColors.red),
                                        filled: true,
                                        fillColor: AppColors.background2,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            borderSide: BorderSide.none),
                                        hintText:
                                            AppLocalizations.of(context)!.name,
                                        hintStyle: GoogleFonts.inter(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                        labelText:
                                            AppLocalizations.of(context)!.name,
                                        labelStyle: GoogleFonts.inter(
                                            color: Colors.blue,
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
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller: firstDateNController,
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: AppColors.red),
                                              filled: true,
                                              fillColor: AppColors.background2,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  borderSide: BorderSide.none),
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .birthday,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(3000));

                                              /// check if date isn't null
                                              if (pickedDate != null) {
                                                // ignore: use_build_context_synchronously
                                                BlocProvider.of<AddClientBloc>(
                                                        context)
                                                    .add(
                                                        AddClientSelectFirstDateNEvent(
                                                            date: pickedDate));
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          child: TextFormField(
                                            controller: secondDateNController,
                                            readOnly: true,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: AppColors.red),
                                              filled: true,
                                              fillColor: AppColors.background2,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  borderSide: BorderSide.none),
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .birthday,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(3000));

                                              /// check if date isn't null
                                              if (pickedDate != null) {
                                                // ignore: use_build_context_synchronously
                                                BlocProvider.of<AddClientBloc>(
                                                        context)
                                                    .add(
                                                        AddClientSelectSecondDateNEvent(
                                                            date: pickedDate));
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 16.0),
                                        // Flexible(
                                        //   child: TextFormField(
                                        //     controller: numComptecontroller,
                                        //     autovalidateMode:
                                        //         AutovalidateMode.onUserInteraction,
                                        //     style: GoogleFonts.inter(
                                        //         color: AppColors.colorTextInput,
                                        //         fontSize: 15,
                                        //         fontWeight: FontWeight.w400),
                                        //     cursorColor: AppColors.colorTextInput,
                                        //     keyboardType: TextInputType.text,
                                        //     decoration: InputDecoration(
                                        //       errorStyle: TextStyle(color: AppColors.red),
                                        //       filled: true,
                                        //       fillColor: AppColors.background2,
                                        //       border: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(16.0),
                                        //           borderSide: BorderSide.none),
                                        //       hintText:
                                        //           AppLocalizations.of(context)!.genre,
                                        //       hintStyle: GoogleFonts.inter(
                                        //           color: Colors.grey,
                                        //           fontSize: 15,
                                        //           fontWeight: FontWeight.w400),
                                        //     ),
                                        //     validator: (value) {
                                        //       if (value!.isEmpty) {
                                        //         return AppLocalizations.of(context)!
                                        //             .empty_input;
                                        //       }
                                        //       return null;
                                        //     },
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),

                                    TextFormField(
                                      controller: lieuNController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      cursorColor: AppColors.colorTextInput,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: AppColors.red),
                                        filled: true,
                                        fillColor: AppColors.background2,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            borderSide: BorderSide.none),
                                        labelText: AppLocalizations.of(context)!
                                            .birthplace,
                                        labelStyle: GoogleFonts.inter(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                        hintText: AppLocalizations.of(context)!
                                            .birthplace,
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
                                    // TextFormField(
                                    //   controller: nomController,
                                    //   autovalidateMode:
                                    //       AutovalidateMode.onUserInteraction,
                                    //   style: GoogleFonts.inter(
                                    //       color: AppColors.colorTextInput,
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w400),
                                    //   cursorColor: AppColors.colorTextInput,
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //     errorStyle: TextStyle(color: AppColors.red),
                                    //     filled: true,
                                    //     fillColor: AppColors.background2,
                                    //     border: OutlineInputBorder(
                                    //         borderRadius: BorderRadius.circular(16.0),
                                    //         borderSide: BorderSide.none),
                                    //     hintText:
                                    //         AppLocalizations.of(context)!.acc_number,
                                    //     hintStyle: GoogleFonts.inter(
                                    //         color: Colors.grey,
                                    //         fontSize: 15,
                                    //         fontWeight: FontWeight.w400),
                                    //   ),
                                    //   validator: (value) {
                                    //     if (value!.isEmpty) {
                                    //       return AppLocalizations.of(context)!
                                    //           .empty_input;
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    // const SizedBox(height: 16.0),
                                    // TextFormField(
                                    //   controller: nomController,
                                    //   autovalidateMode:
                                    //       AutovalidateMode.onUserInteraction,
                                    //   style: GoogleFonts.inter(
                                    //       color: AppColors.colorTextInput,
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w400),
                                    //   cursorColor: AppColors.colorTextInput,
                                    //   keyboardType: TextInputType.text,
                                    //   decoration: InputDecoration(
                                    //     errorStyle: TextStyle(color: AppColors.red),
                                    //     filled: true,
                                    //     fillColor: AppColors.background2,
                                    //     border: OutlineInputBorder(
                                    //         borderRadius: BorderRadius.circular(16.0),
                                    //         borderSide: BorderSide.none),
                                    //     hintText:
                                    //         AppLocalizations.of(context)!.acc_number,
                                    //     hintStyle: GoogleFonts.inter(
                                    //         color: Colors.grey,
                                    //         fontSize: 15,
                                    //         fontWeight: FontWeight.w400),
                                    //   ),
                                    //   validator: (value) {
                                    //     if (value!.isEmpty) {
                                    //       return AppLocalizations.of(context)!
                                    //           .empty_input;
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(
                                          child: DropdownButtonFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: GoogleFonts.inter(
                                                  color:
                                                      AppColors.colorTextInput,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'M',
                                                  child: TypoText(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .man,
                                                          color: AppColors
                                                              .colorTextPrimary)
                                                      .long(),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'F',
                                                  child: TypoText(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .women,
                                                          color: AppColors
                                                              .colorTextPrimary)
                                                      .long(),
                                                ),
                                              ],
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: AppColors.red),
                                                filled: true,
                                                fillColor:
                                                    AppColors.background2,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              value: selectedGenretype,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGenretype = value!;
                                                });
                                              }),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          child: DropdownButtonFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: GoogleFonts.inter(
                                                  color:
                                                      AppColors.colorTextInput,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'En',
                                                  child: TypoText(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .en,
                                                          color: AppColors
                                                              .colorTextPrimary)
                                                      .long(),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Fr',
                                                  child: TypoText(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .fr,
                                                          color: AppColors
                                                              .colorTextPrimary)
                                                      .long(),
                                                ),
                                              ],
                                              decoration: InputDecoration(
                                                errorStyle: TextStyle(
                                                    color: AppColors.red),
                                                filled: true,
                                                fillColor:
                                                    AppColors.background2,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    borderSide:
                                                        BorderSide.none),
                                              ),
                                              value: selectedLangtype,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedLangtype = value!;
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        isActive: currentStep >= 0),
                    Step(
                        title: TypoText(
                                text: AppLocalizations.of(context)!.step + " 2",
                                color: AppColors.colorTextInput)
                            .longCast(),
                        subtitle: TypoText(
                                text: AppLocalizations.of(context)!.cni,
                                color: AppColors.colorTextInput)
                            .longCast(),
                        content: Column(
                          children: [
                            Form(
                              key: formKeyDoc,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: ncniController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: GoogleFonts.inter(
                                        color: AppColors.colorTextInput,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: AppColors.colorTextInput,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: AppColors.red),
                                      filled: true,
                                      fillColor: AppColors.background2,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none),
                                      labelText:
                                          AppLocalizations.of(context)!.cni,
                                      labelStyle: GoogleFonts.inter(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      hintText:
                                          AppLocalizations.of(context)!.cni,
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
                                    controller: cncniController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: GoogleFonts.inter(
                                        color: AppColors.colorTextInput,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: AppColors.colorTextInput,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: AppColors.red),
                                      filled: true,
                                      fillColor: AppColors.background2,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none),
                                      labelText:
                                          AppLocalizations.of(context)!.cni,
                                      labelStyle: GoogleFonts.inter(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      hintText:
                                          AppLocalizations.of(context)!.cni,
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
                                  Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: firstDateCNIController,
                                          readOnly: true,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: GoogleFonts.inter(
                                              color: AppColors.colorTextInput,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                          cursorColor: AppColors.colorTextInput,
                                          keyboardType: TextInputType.datetime,
                                          decoration: InputDecoration(
                                            errorStyle:
                                                TextStyle(color: AppColors.red),
                                            filled: true,
                                            fillColor: AppColors.background2,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                borderSide: BorderSide.none),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .date,
                                            hintStyle: GoogleFonts.inter(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .empty_input;
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate1 =
                                                await showDatePicker(
                                                    context: context,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(3000));

                                            /// check if date isn't null
                                            if (pickedDate1 != null) {
                                              // ignore: use_build_context_synchronously
                                              BlocProvider.of<AddClientBloc>(
                                                      context)
                                                  .add(
                                                      AddClientSelectFirstDateCNIEvent(
                                                          date1: pickedDate1));
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Flexible(
                                        child: TextFormField(
                                          controller: secondDateCNIController,
                                          readOnly: true,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: GoogleFonts.inter(
                                              color: AppColors.colorTextInput,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                          cursorColor: AppColors.colorTextInput,
                                          keyboardType: TextInputType.datetime,
                                          decoration: InputDecoration(
                                            errorStyle:
                                                TextStyle(color: AppColors.red),
                                            filled: true,
                                            fillColor: AppColors.background2,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                borderSide: BorderSide.none),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .date,
                                            hintStyle: GoogleFonts.inter(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .empty_input;
                                            }
                                            return null;
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate1 =
                                                await showDatePicker(
                                                    context: context,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(3000));

                                            /// check if date isn't null
                                            if (pickedDate1 != null) {
                                              // ignore: use_build_context_synchronously
                                              BlocProvider.of<AddClientBloc>(
                                                      context)
                                                  .add(
                                                      AddClientSelectSecondDateCNIEvent(
                                                          date1: pickedDate1));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: lieuCNIController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: GoogleFonts.inter(
                                        color: AppColors.colorTextInput,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: AppColors.colorTextInput,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: AppColors.red),
                                      filled: true,
                                      fillColor: AppColors.background2,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none),
                                      labelText: AppLocalizations.of(context)!
                                          .placecni,
                                      labelStyle: GoogleFonts.inter(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      hintText: AppLocalizations.of(context)!
                                          .placecni,
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
                                    controller: professionController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: GoogleFonts.inter(
                                        color: AppColors.colorTextInput,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    cursorColor: AppColors.colorTextInput,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      errorStyle:
                                          TextStyle(color: AppColors.red),
                                      filled: true,
                                      fillColor: AppColors.background2,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          borderSide: BorderSide.none),
                                      labelText: AppLocalizations.of(context)!
                                          .profession,
                                      labelStyle: GoogleFonts.inter(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      hintText: AppLocalizations.of(context)!
                                          .profession,
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
                                  // Flexible(
                                  //   child: DropdownButtonFormField(
                                  //       items: const [
                                  //         DropdownMenuItem(
                                  //             value: 'Fr', child: Text("Fr")),
                                  //         DropdownMenuItem(
                                  //             value: 'En', child: Text("En")),
                                  //       ],
                                  //       decoration:
                                  //           InputDecoration(border: OutlineInputBorder()),
                                  //       value: selectedLangtype,
                                  //       onChanged: (value) {
                                  //         setState(() {
                                  //           selectedLangtype = value!;
                                  //         });
                                  //       }),
                                  // ),

                                  const SizedBox(height: 16.0),
                                ],
                              ),
                            )
                          ],
                        ),
                        isActive: currentStep >= 1)
                  ],
                ),
              ),
            ],
          );
        }),
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

  Widget controlsBuilder(BuildContext context, ControlsDetails details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonComponent(
            onPressed: details.onStepContinue,
            child: currentStep > 0
                ? InkWell(
                    child: TypoText(
                            text: AppLocalizations.of(context)!.validate,
                            color: AppColors.colorTextWhite)
                        .h2(),
                    onTap: () {
                      validate();
                    },
                  )
                : InkWell(
                    child: TypoText(
                            text: AppLocalizations.of(context)!.next,
                            color: AppColors.colorTextWhite)
                        .h2(),
                    onTap: () {
                      nextstep();
                    },
                  ),
            color: AppColors.backgroundButton),
        InkWell(
          onTap: () {
            print("cancel");
          },
          child: ButtonComponent(
              onPressed: details.onStepCancel,
              child: TypoText(
                      text: AppLocalizations.of(context)!.cancel,
                      color: AppColors.backgroundButton)
                  .h2(),
              color: AppColors.background),
        ),
      ],
    );
  }
}

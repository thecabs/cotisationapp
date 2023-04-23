import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/client/client_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/components/button_component.dart';
import 'package:gpt/models/user_model.dart';
import 'package:gpt/models/addclient_model.dart';
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
      child: ClientScreen(
        userModel: userModel,
      ),
    );
  }
}

class ClientScreen extends StatefulWidget {
  final UserModel userModel;
  const ClientScreen({
    super.key,
    required this.userModel,
  });
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  //final formKey = GlobalKey<FormState>();

  final formKeyCNI = GlobalKey<FormState>();
  final formKeyClient = GlobalKey<FormState>();
  bool step1ok = false;
  bool step2ok = false;
  var idClient;
  var idAgence;

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
    if (mobilecontroller.value == cmobilecontroller.value) {
      return true;
    } else {
      return false;
    }
  }

  bool dateNConfirmed() {
    if (firstDateNController.text.toString() ==
        secondDateNController.text.toString()) {
      return true;
    } else {
      return false;
    }
  }

  bool dateCNIConfirmed() {
    if (firstDateCNIController.text.toString() ==
        secondDateCNIController.text.toString()) {
      return true;
    } else {
      return false;
    }
  }

  bool ncniConfirmed() {
    if (ncniController.text.toString() == cncniController.text.toString()) {
      return true;
    } else {
      return false;
    }
  }

  // bool datecniConfirmed() {
  //   if (firstDateCNIController.value == secondDateCNIController.value) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  verificationstep1() {
    // do {
    //   firstDateNController.clear();
    //   secondDateNController.clear();
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           backgroundColor: AppColors.backgroundButton,
    //           content: TypoText(
    //                   text: "Date Naissance Incorrecte",
    //                   color: AppColors.colorTextInput)
    //               .long(),
    //         );
    //       });
    // } while (dateNConfirmed() == false);

    // do {
    //   mobilecontroller.clear();
    //   cmobilecontroller.clear();
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           backgroundColor: AppColors.backgroundButton,
    //           content: TypoText(
    //                   text: "Mobile Incorrect", color: AppColors.colorTextInput)
    //               .long(),
    //         );
    //       });
    // } while (mobileConfirmed() == false);

    if (mobileConfirmed() == true) {
      if (dateNConfirmed() == true) {
        onStepContinue();
      } else {
        firstDateNController.clear();
        secondDateNController.clear();
        hideSnackBar(context);
        showSnackBar(context, AppLocalizations.of(context)!.error_birthday, 4);
      }
    } else {
      mobilecontroller.clear();
      cmobilecontroller.clear();

      hideSnackBar(context);
      showSnackBar(context, AppLocalizations.of(context)!.error_mobile, 4);
    }
  }

  verificationstep2() {
    if (ncniConfirmed() == true) {
      if (dateCNIConfirmed() == true) {
        step2ok = true;
        return step2ok;
      } else {
        firstDateCNIController.clear();
        secondDateCNIController.clear();
        hideSnackBar(context);
        showSnackBar(context, AppLocalizations.of(context)!.error_datecni, 4);
      }
    } else {
      ncniController.clear();
      cncniController.clear();
      hideSnackBar(context);
      showSnackBar(context, AppLocalizations.of(context)!.error_cni, 4);
    }
  }

  // Future nextstep1() async {
  //   do {
  //     mobilecontroller.clear();
  //     cmobilecontroller.clear();
  //     firstDateNController.clear();
  //     secondDateNController.clear();
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             backgroundColor: AppColors.backgroundButton,
  //             content: TypoText(
  //                     text: AppLocalizations.of(context)!.authentication_error,
  //                     color: AppColors.colorTextInput)
  //                 .longCast(),
  //           );
  //         });
  //   } while (mobileConfirmed() == true && dateNConfirmed() == true);
  // }

  // Future validate() async {}

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
      //currentStep = value;
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
          if (state is ClientErrorSave) {
            hideSnackBar(context);

            showSnackBar(
                context, AppLocalizations.of(context)!.error_addclient, 2);
          }
          if (state is ClientSave) {
            hideSnackBar(context);
            showSnackBar(
                context, AppLocalizations.of(context)!.addclientsuccess, 5);
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
                  //onStepTapped: onStepTapped,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          if (currentStep == 0)
                            ButtonComponent(
                                onPressed: () {
                                  print(widget.userModel.idZone);

                                  if (formKeyClient.currentState!.validate()) {
                                    verificationstep1();
                                  }
                                },
                                child: TypoText(
                                        text:
                                            AppLocalizations.of(context)!.next,
                                        color: AppColors.colorTextWhite)
                                    .h2(),
                                color: AppColors.backgroundButton),
                          // ButtonComponent(
                          //     onPressed: controls.onStepContinue,
                          //     child: currentStep > 0
                          //         ? InkWell(
                          //             onTap: () {
                          //               if (formKeyCNI.currentState!
                          //                   .validate()) {
                          //                 do {
                          //                   //controls.onStepContinue;
                          //                   verificationstep2();
                          //                 } while (step1ok);
                          //               }
                          //             },
                          //             child: TypoText(
                          //                     text:
                          //                         AppLocalizations.of(context)!
                          //                             .validate,
                          //                     color: AppColors.colorTextWhite)
                          //                 .h2(),
                          //           )
                          //         : GestureDetector(
                          //             onTap: () {
                          //               if (formKeyClient.currentState!
                          //                   .validate()) {
                          //                 do {
                          //                   controls.onStepContinue;
                          //                   verificationstep1();
                          //                 } while (step2ok);

                          //                 //verificationstep1();
                          //               }
                          //             },
                          //             child: TypoText(
                          //                     text:
                          //                         AppLocalizations.of(context)!
                          //                             .next,
                          //                     color: AppColors.colorTextWhite)
                          //                 .h2(),
                          //           ),
                          //     color: AppColors.backgroundButton),
                          // if (currentStep == 1)
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       ButtonComponent(
                          //           onPressed: controls.onStepCancel,
                          //           child: TypoText(
                          //                   text: AppLocalizations.of(context)!
                          //                       .cancel,
                          //                   color: AppColors.backgroundButton)
                          //               .h2(),
                          //           color: AppColors.background),
                          if (currentStep == 1)
                            ButtonComponent(
                                onPressed: controls.onStepCancel,
                                child: TypoText(
                                        text: AppLocalizations.of(context)!
                                            .cancel,
                                        color: AppColors.background)
                                    .h2(),
                                color: AppColors.backgroundButton),
                          if (currentStep == 1)
                            ButtonComponent(
                              onPressed: () {
                                if (formKeyCNI.currentState!.validate()) {
                                  verificationstep2();
                                  if (step2ok == true) {
                                    final addclientModel = AddClientModel(
                                      mobile: mobilecontroller.text.trim(),
                                      username: nomController.text,
                                      daten: firstDateCNIController.text.trim(),
                                      lieun: lieuNController.text.trim(),
                                      genre: selectedGenretype.toString(),
                                      lang: selectedLangtype.toString(),
                                      numcni: ncniController.text.trim(),
                                      datecni:
                                          firstDateCNIController.text.trim(),
                                      lieucni: lieuCNIController.text.trim(),
                                      profession:
                                          professionController.text.trim(),
                                      idUser: widget.userModel.id!,
                                      idAgence: widget.userModel.idAgence,
                                      idZone: widget.userModel.idZone!,
                                    );
                                    context
                                        .read<AddClientBloc>()
                                        .add(AddClientDataEvent(
                                          addclientModel: addclientModel,
                                        ));
                                  }
                                }
                              },
                              color: AppColors.backgroundButton,
                              child: TypoText(
                                      text: (state is ClientSave)
                                          ? AppLocalizations.of(context)!
                                              .addclient
                                          : AppLocalizations.of(context)!
                                              .validate,
                                      color: AppColors.colorTextWhite)
                                  .h2(),
                            )
                        ],
                      ),
                    );
                  },
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
                                            keyboardType: TextInputType.number,
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
                                            keyboardType: TextInputType.number,
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
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Form(
                                key: formKeyCNI,
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
                                                      .datedelcni,
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
                                                          TextInputType
                                                              .datetime,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(3000));

                                              /// check if date isn't null
                                              if (pickedDate1 != null) {
                                                // ignore: use_build_context_synchronously
                                                BlocProvider.of<AddClientBloc>(
                                                        context)
                                                    .add(
                                                        AddClientSelectFirstDateCNIEvent(
                                                            date1:
                                                                pickedDate1));
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
                                                      .datedelcni,
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
                                                          TextInputType
                                                              .datetime,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(3000));

                                              /// check if date isn't null
                                              if (pickedDate1 != null) {
                                                // ignore: use_build_context_synchronously
                                                BlocProvider.of<AddClientBloc>(
                                                        context)
                                                    .add(
                                                        AddClientSelectSecondDateCNIEvent(
                                                            date1:
                                                                pickedDate1));
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

//   Widget controlsBuilder(BuildContext context, ControlsDetails details) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ButtonComponent(
//             onPressed: details.onStepContinue,
//             child: currentStep > 0
//                 ? InkWell(
//                     child: TypoText(
//                             text: AppLocalizations.of(context)!.validate,
//                             color: AppColors.colorTextWhite)
//                         .h2(),
//                     onTap: () {
//                       if (formKeyCNI.currentState!.validate()) {
//                         // verificationstep2();
//                         //if ((step1ok == true) && (step2ok == true)) {
//                         final addclientModel = AddClientModel(
//                           mobile: mobilecontroller.text.trim(),
//                           username: nomController.text,
//                           daten: firstDateCNIController.text.trim(),
//                           lieun: lieuNController.text.trim(),
//                           genre: selectedGenretype.toString(),
//                           lang: selectedLangtype.toString(),
//                           numcni: ncniController.text.trim(),
//                           datecni: firstDateCNIController.text.trim(),
//                           lieucni: lieuCNIController.text.trim(),
//                           profession: professionController.text.trim(),
//                           //idUser: firstDateCNIController.text.trim(),
//                           //idAgence: lieuCNIController.text.trim(),
//                           //idZone: professionController.text.trim(),
//                         );

//                         BlocProvider.of<AddClientBloc>(context)
//                             .add(AddClientDataEvent(
//                           addclientModel: addclientModel,
//                         ));
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 content: TypoText(
//                                         text: AppLocalizations.of(context)!
//                                             .loading,
//                                         color: AppColors.colorTextWhite)
//                                     .h2(),
//                               );
//                             });
//                         //}
//                       }
//                     })
//                 : InkWell(
//                     child: TypoText(
//                             text: AppLocalizations.of(context)!.next,
//                             color: AppColors.colorTextWhite)
//                         .h2(),
//                     onTap: () {
//                       if (formKeyClient.currentState!.validate()) {
//                         verificationstep1();
//                       }
//                     },
//                   ),
//             color: AppColors.backgroundButton),
//         InkWell(
//           onTap: () {
//             print("cancel");
//           },
//           child: ButtonComponent(
//               onPressed: details.onStepCancel,
//               child: TypoText(
//                       text: AppLocalizations.of(context)!.cancel,
//                       color: AppColors.backgroundButton)
//                   .h2(),
//               color: AppColors.background),
//         ),
//       ],
//     );
//   }

  hideSnackBar(BuildContext context) => ScaffoldMessenger.of(context)
      .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);

  showSnackBar(BuildContext context, String text, int duration) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.backgroundButton,
          duration: Duration(seconds: duration),
          content: TypoText(text: text, color: Colors.white).h3()));
}

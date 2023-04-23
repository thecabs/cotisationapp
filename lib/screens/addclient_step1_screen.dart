// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gpt/blocs/client/client_bloc.dart';
// import 'package:gpt/models/user_model.dart';
// import 'package:gpt/screens/addclient_step2_screen.dart';
// import 'package:gpt/screens/authentication_screen.dart';
// import 'package:gpt/screens/second_screen.dart';
// import 'package:gpt/utils/app_colors.dart';
// import 'package:gpt/utils/custom_date.dart';
// import 'package:gpt/utils/typography.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../blocs/first_screen/first_screen_bloc.dart';
// import '../components/button_component.dart';
// import 'main_screen.dart';

// class AddClientStep1Screen extends StatelessWidget {
//   final formKey = GlobalKey<FormState>();
//   //final formKeyCNI = GlobalKey<FormState>();
//   final formKeyClient = GlobalKey<FormState>();
//   bool step1ok = false;
//   bool step2ok = false;
//   // controllers client
//   final mobilecontroller = TextEditingController();
//   final cmobilecontroller = TextEditingController();
//   final nomController = TextEditingController();
//   final firstDateNController = TextEditingController();
//   final secondDateNController = TextEditingController();
//   final lieuNController = TextEditingController();

//   String selectedGenretype = 'F';

//   String selectedLangtype = 'Fr';

//   // controllers cni

//   var addclientBloc;

//   // verification of fields
//   bool mobileConfirmed() {
//     if (mobilecontroller.value == cmobilecontroller.value) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   bool dateNConfirmed() {
//     if (firstDateNController.text.toString() ==
//         secondDateNController.text.toString()) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   // Future verificationstep2() async {
//   //   if (ncniConfirmed() == true) {
//   //     if (dateCNIConfirmed() == true) {
//   //       return step1ok;
//   //     } else {
//   //       firstDateCNIController.clear();
//   //       secondDateCNIController.clear();
//   //       showDialog(
//   //           context: context,
//   //           builder: (context) {
//   //             return AlertDialog(
//   //               backgroundColor: AppColors.backgroundButton,
//   //               content: TypoText(
//   //                       text: "Date CNI Incorrecte",
//   //                       color: AppColors.colorTextInput)
//   //                   .longCast(),
//   //             );
//   //           });
//   //     }
//   //   } else {
//   //     ncniController.clear();
//   //     cncniController.clear();

//   //     showDialog(
//   //         context: context,
//   //         builder: (context) {
//   //           return AlertDialog(
//   //             backgroundColor: AppColors.backgroundButton,
//   //             content: TypoText(
//   //                     text: "Numero de CNI Incorrect",
//   //                     color: AppColors.colorTextInput)
//   //                 .longCast(),
//   //           );
//   //         });
//   //   }
//   // }

//   late SharedPreferences sharedPreferences;

//   AddClientStep1Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     clearFields() {
//       mobilecontroller.clear();
//       cmobilecontroller.clear();
//       nomController.clear();
//       firstDateNController.clear();
//       secondDateNController.clear();
//       lieuNController.clear();
//     }

//     return BlocProvider(
//       create: (BuildContext context) => AddClientBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.background,
//           title: TypoText(
//                   text: AppLocalizations.of(context)!.client,
//                   color: AppColors.colorTextInput)
//               .large(),
//         ),
//         body: BlocConsumer<AddClientBloc, AddClientState>(
//           listener: (context, state) {
//             if (state is ClientErrorState) {
//               hideSnackBar(context);
//               showSnackBar(
//                   context, AppLocalizations.of(context)!.not_found_bank, 2);
//             }
//             if (state is AddClientInitial) {
//               clearFields();
//             }

//             if (state is AddClientSelectFirstDateNState) {
//               firstDateNController.text = CustomDate.custom(state.date);
//             }

//             if (state is AddClientSelectSecondDateNState) {
//               secondDateNController.text = CustomDate.custom(state.date);
//             }
//           },
//           builder: (context, state) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Container(
//                       height: 5,
//                       width: double.infinity,
//                       decoration: BoxDecoration(color: AppColors.red)),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Flexible(
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Center(
//                                   child: TypoText(
//                                           text: AppLocalizations.of(context)!
//                                               .info_client,
//                                           color: AppColors.colorTextInput)
//                                       .large(),
//                                 ),
//                                 const SizedBox(height: 20.0),
//                                 Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                   children: [
//                                     const SizedBox(height: 20.0),
//                                     Column(
//                                       children: [
//                                         Form(
//                                           key: formKeyClient,
//                                           child: Column(
//                                             children: [
//                                               SizedBox(height: 16),
//                                               SingleChildScrollView(
//                                                 child: Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Flexible(
//                                                       child: TextFormField(
//                                                         controller:
//                                                             mobilecontroller,
//                                                         autovalidateMode:
//                                                             AutovalidateMode
//                                                                 .onUserInteraction,
//                                                         style: GoogleFonts.inter(
//                                                             color: AppColors
//                                                                 .colorTextInput,
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                         cursorColor: AppColors
//                                                             .colorTextInput,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                         decoration:
//                                                             InputDecoration(
//                                                           errorStyle: TextStyle(
//                                                               color: AppColors
//                                                                   .red),
//                                                           filled: true,
//                                                           fillColor: AppColors
//                                                               .background2,
//                                                           border: OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           16.0),
//                                                               borderSide:
//                                                                   BorderSide
//                                                                       .none),
//                                                           hintText:
//                                                               AppLocalizations.of(
//                                                                       context)!
//                                                                   .phone,
//                                                           hintStyle:
//                                                               GoogleFonts.inter(
//                                                                   color: Colors
//                                                                       .grey,
//                                                                   fontSize: 15,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400),
//                                                           labelText:
//                                                               AppLocalizations.of(
//                                                                       context)!
//                                                                   .phone,
//                                                           labelStyle:
//                                                               GoogleFonts.inter(
//                                                                   color: Colors
//                                                                       .blue,
//                                                                   fontSize: 15,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400),
//                                                         ),
//                                                         validator: (value) {
//                                                           if (value!.isEmpty) {
//                                                             return AppLocalizations
//                                                                     .of(context)!
//                                                                 .empty_input;
//                                                           }
//                                                           return null;
//                                                         },
//                                                       ),
//                                                     ),
//                                                     const SizedBox(width: 16.0),
//                                                     Flexible(
//                                                       child: TextFormField(
//                                                         controller:
//                                                             cmobilecontroller,
//                                                         autovalidateMode:
//                                                             AutovalidateMode
//                                                                 .onUserInteraction,
//                                                         style: GoogleFonts.inter(
//                                                             color: AppColors
//                                                                 .colorTextInput,
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                         cursorColor: AppColors
//                                                             .colorTextInput,
//                                                         keyboardType:
//                                                             TextInputType
//                                                                 .number,
//                                                         decoration: InputDecoration(
//                                                             errorStyle: TextStyle(
//                                                                 color: AppColors
//                                                                     .red),
//                                                             filled: true,
//                                                             fillColor: AppColors
//                                                                 .background2,
//                                                             border: OutlineInputBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius.circular(
//                                                                         16.0),
//                                                                 borderSide: BorderSide
//                                                                     .none),
//                                                             hintText: AppLocalizations.of(context)!
//                                                                 .phone,
//                                                             hintStyle: GoogleFonts.inter(
//                                                                 color:
//                                                                     Colors.grey,
//                                                                 fontSize: 15,
//                                                                 fontWeight: FontWeight
//                                                                     .w400),
//                                                             labelText:
//                                                                 AppLocalizations.of(context)!
//                                                                     .phone,
//                                                             labelStyle: GoogleFonts.inter(
//                                                                 color: Colors.blue,
//                                                                 fontSize: 15,
//                                                                 fontWeight: FontWeight.w400)),
//                                                         validator: (value) {
//                                                           if (value!.isEmpty) {
//                                                             return AppLocalizations
//                                                                     .of(context)!
//                                                                 .empty_input;
//                                                           }
//                                                           return null;
//                                                         },
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               SizedBox(height: 16),
//                                               TextFormField(
//                                                 controller: nomController,
//                                                 autovalidateMode:
//                                                     AutovalidateMode
//                                                         .onUserInteraction,
//                                                 style: GoogleFonts.inter(
//                                                     color: AppColors
//                                                         .colorTextInput,
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                                 cursorColor:
//                                                     AppColors.colorTextInput,
//                                                 keyboardType:
//                                                     TextInputType.text,
//                                                 decoration: InputDecoration(
//                                                   errorStyle: TextStyle(
//                                                       color: AppColors.red),
//                                                   filled: true,
//                                                   fillColor:
//                                                       AppColors.background2,
//                                                   border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16.0),
//                                                       borderSide:
//                                                           BorderSide.none),
//                                                   hintText: AppLocalizations.of(
//                                                           context)!
//                                                       .name,
//                                                   hintStyle: GoogleFonts.inter(
//                                                       color: Colors.grey,
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                   labelText:
//                                                       AppLocalizations.of(
//                                                               context)!
//                                                           .name,
//                                                   labelStyle: GoogleFonts.inter(
//                                                       color: Colors.blue,
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return AppLocalizations.of(
//                                                             context)!
//                                                         .empty_input;
//                                                   }
//                                                   return null;
//                                                 },
//                                               ),
//                                               const SizedBox(height: 16.0),
//                                               Row(
//                                                 children: [
//                                                   Flexible(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           firstDateNController,
//                                                       readOnly: true,
//                                                       autovalidateMode:
//                                                           AutovalidateMode
//                                                               .onUserInteraction,
//                                                       style: GoogleFonts.inter(
//                                                           color: AppColors
//                                                               .colorTextInput,
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                       cursorColor: AppColors
//                                                           .colorTextInput,
//                                                       keyboardType:
//                                                           TextInputType
//                                                               .datetime,
//                                                       decoration:
//                                                           InputDecoration(
//                                                         errorStyle: TextStyle(
//                                                             color:
//                                                                 AppColors.red),
//                                                         filled: true,
//                                                         fillColor: AppColors
//                                                             .background2,
//                                                         border: OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         16.0),
//                                                             borderSide:
//                                                                 BorderSide
//                                                                     .none),
//                                                         hintText:
//                                                             AppLocalizations.of(
//                                                                     context)!
//                                                                 .birthday,
//                                                         hintStyle:
//                                                             GoogleFonts.inter(
//                                                                 color:
//                                                                     Colors.blue,
//                                                                 fontSize: 15,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400),
//                                                       ),
//                                                       validator: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return AppLocalizations
//                                                                   .of(context)!
//                                                               .empty_input;
//                                                         }
//                                                         return null;
//                                                       },
//                                                       onTap: () async {
//                                                         DateTime? pickedDate =
//                                                             await showDatePicker(
//                                                                 context:
//                                                                     context,
//                                                                 keyboardType:
//                                                                     TextInputType
//                                                                         .datetime,
//                                                                 initialDate:
//                                                                     DateTime
//                                                                         .now(),
//                                                                 firstDate:
//                                                                     DateTime(
//                                                                         1900),
//                                                                 lastDate:
//                                                                     DateTime(
//                                                                         3000));

//                                                         /// check if date isn't null
//                                                         if (pickedDate !=
//                                                             null) {
//                                                           // ignore: use_build_context_synchronously
//                                                           BlocProvider.of<
//                                                                       AddClientBloc>(
//                                                                   context)
//                                                               .add(AddClientSelectFirstDateNEvent(
//                                                                   date:
//                                                                       pickedDate));
//                                                         }
//                                                       },
//                                                     ),
//                                                   ),
//                                                   const SizedBox(width: 16.0),
//                                                   Flexible(
//                                                     child: TextFormField(
//                                                       controller:
//                                                           secondDateNController,
//                                                       readOnly: true,
//                                                       autovalidateMode:
//                                                           AutovalidateMode
//                                                               .onUserInteraction,
//                                                       style: GoogleFonts.inter(
//                                                           color: AppColors
//                                                               .colorTextInput,
//                                                           fontSize: 15,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                       cursorColor: AppColors
//                                                           .colorTextInput,
//                                                       keyboardType:
//                                                           TextInputType
//                                                               .datetime,
//                                                       decoration:
//                                                           InputDecoration(
//                                                         errorStyle: TextStyle(
//                                                             color:
//                                                                 AppColors.red),
//                                                         filled: true,
//                                                         fillColor: AppColors
//                                                             .background2,
//                                                         border: OutlineInputBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         16.0),
//                                                             borderSide:
//                                                                 BorderSide
//                                                                     .none),
//                                                         hintText:
//                                                             AppLocalizations.of(
//                                                                     context)!
//                                                                 .birthday,
//                                                         hintStyle:
//                                                             GoogleFonts.inter(
//                                                                 color:
//                                                                     Colors.blue,
//                                                                 fontSize: 15,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400),
//                                                       ),
//                                                       validator: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return AppLocalizations
//                                                                   .of(context)!
//                                                               .empty_input;
//                                                         }
//                                                         return null;
//                                                       },
//                                                       onTap: () async {
//                                                         DateTime? pickedDate =
//                                                             await showDatePicker(
//                                                                 context:
//                                                                     context,
//                                                                 keyboardType:
//                                                                     TextInputType
//                                                                         .datetime,
//                                                                 initialDate:
//                                                                     DateTime
//                                                                         .now(),
//                                                                 firstDate:
//                                                                     DateTime(
//                                                                         1900),
//                                                                 lastDate:
//                                                                     DateTime(
//                                                                         3000));

//                                                         /// check if date isn't null
//                                                         if (pickedDate !=
//                                                             null) {
//                                                           // ignore: use_build_context_synchronously
//                                                           BlocProvider.of<
//                                                                       AddClientBloc>(
//                                                                   context)
//                                                               .add(AddClientSelectSecondDateNEvent(
//                                                                   date:
//                                                                       pickedDate));
//                                                         }
//                                                       },
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 16.0),
//                                               TextFormField(
//                                                 controller: lieuNController,
//                                                 autovalidateMode:
//                                                     AutovalidateMode
//                                                         .onUserInteraction,
//                                                 style: GoogleFonts.inter(
//                                                     color: AppColors
//                                                         .colorTextInput,
//                                                     fontSize: 15,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                                 cursorColor:
//                                                     AppColors.colorTextInput,
//                                                 keyboardType:
//                                                     TextInputType.text,
//                                                 decoration: InputDecoration(
//                                                   errorStyle: TextStyle(
//                                                       color: AppColors.red),
//                                                   filled: true,
//                                                   fillColor:
//                                                       AppColors.background2,
//                                                   border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16.0),
//                                                       borderSide:
//                                                           BorderSide.none),
//                                                   labelText:
//                                                       AppLocalizations.of(
//                                                               context)!
//                                                           .birthplace,
//                                                   labelStyle: GoogleFonts.inter(
//                                                       color: Colors.blue,
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                   hintText: AppLocalizations.of(
//                                                           context)!
//                                                       .birthplace,
//                                                   hintStyle: GoogleFonts.inter(
//                                                       color: Colors.grey,
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return AppLocalizations.of(
//                                                             context)!
//                                                         .empty_input;
//                                                   }
//                                                   return null;
//                                                 },
//                                               ),
//                                               const SizedBox(height: 16.0),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceEvenly,
//                                                 children: [
//                                                   Flexible(
//                                                     child:
//                                                         DropdownButtonFormField(
//                                                             autovalidateMode:
//                                                                 AutovalidateMode
//                                                                     .onUserInteraction,
//                                                             style: GoogleFonts.inter(
//                                                                 color: AppColors
//                                                                     .colorTextInput,
//                                                                 fontSize: 15,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400),
//                                                             items: [
//                                                               DropdownMenuItem(
//                                                                 value: 'M',
//                                                                 child: TypoText(
//                                                                         text: AppLocalizations.of(context)!
//                                                                             .man,
//                                                                         color: AppColors
//                                                                             .colorTextPrimary)
//                                                                     .long(),
//                                                               ),
//                                                               DropdownMenuItem(
//                                                                 value: 'F',
//                                                                 child: TypoText(
//                                                                         text: AppLocalizations.of(context)!
//                                                                             .women,
//                                                                         color: AppColors
//                                                                             .colorTextPrimary)
//                                                                     .long(),
//                                                               ),
//                                                             ],
//                                                             decoration:
//                                                                 InputDecoration(
//                                                               errorStyle: TextStyle(
//                                                                   color:
//                                                                       AppColors
//                                                                           .red),
//                                                               filled: true,
//                                                               fillColor: AppColors
//                                                                   .background2,
//                                                               border: OutlineInputBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               16.0),
//                                                                   borderSide:
//                                                                       BorderSide
//                                                                           .none),
//                                                             ),
//                                                             value:
//                                                                 selectedGenretype,
//                                                             onChanged: (value) {
//                                                               selectedGenretype =
//                                                                   value!;
//                                                             }),
//                                                   ),
//                                                   const SizedBox(width: 16.0),
//                                                   Flexible(
//                                                     child:
//                                                         DropdownButtonFormField(
//                                                             autovalidateMode:
//                                                                 AutovalidateMode
//                                                                     .onUserInteraction,
//                                                             style: GoogleFonts.inter(
//                                                                 color: AppColors
//                                                                     .colorTextInput,
//                                                                 fontSize: 15,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400),
//                                                             items: [
//                                                               DropdownMenuItem(
//                                                                 value: 'En',
//                                                                 child: TypoText(
//                                                                         text: AppLocalizations.of(context)!
//                                                                             .en,
//                                                                         color: AppColors
//                                                                             .colorTextPrimary)
//                                                                     .long(),
//                                                               ),
//                                                               DropdownMenuItem(
//                                                                 value: 'Fr',
//                                                                 child: TypoText(
//                                                                         text: AppLocalizations.of(context)!
//                                                                             .fr,
//                                                                         color: AppColors
//                                                                             .colorTextPrimary)
//                                                                     .long(),
//                                                               ),
//                                                             ],
//                                                             decoration:
//                                                                 InputDecoration(
//                                                               errorStyle: TextStyle(
//                                                                   color:
//                                                                       AppColors
//                                                                           .red),
//                                                               filled: true,
//                                                               fillColor: AppColors
//                                                                   .background2,
//                                                               border: OutlineInputBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               16.0),
//                                                                   borderSide:
//                                                                       BorderSide
//                                                                           .none),
//                                                             ),
//                                                             value:
//                                                                 selectedLangtype,
//                                                             onChanged: (value) {
//                                                               selectedLangtype =
//                                                                   value!;
//                                                             }),
//                                                   ),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 16.0),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     ButtonComponent(
//                                         onPressed: () {
//                                           if (formKeyClient.currentState!
//                                               .validate()) {
//                                             if (mobileConfirmed() == true) {
//                                               if (dateNConfirmed() == true) {
//                                                 // Navigator.push(
//                                                 //   context,
//                                                 //   MaterialPageRoute(
//                                                 //     builder: (context) {
//                                                 //       return AddClientStep2Screen();
//                                                 //     },
//                                                 //   ),
//                                                 // );
//                                                 Navigator.of(context)
//                                                     .pushAndRemoveUntil(
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 AddClientStep2Screen()),
//                                                         (route) => false);
//                                               } else {
//                                                 firstDateNController.clear();
//                                                 secondDateNController.clear();
//                                                 showDialog(
//                                                     context: context,
//                                                     builder: (context) {
//                                                       return AlertDialog(
//                                                         backgroundColor: AppColors
//                                                             .backgroundButton,
//                                                         content: TypoText(
//                                                                 text:
//                                                                     "Date Naissance Incorrecte",
//                                                                 color: AppColors
//                                                                     .colorTextInput)
//                                                             .longCast(),
//                                                       );
//                                                     });
//                                               }
//                                             } else {
//                                               mobilecontroller.clear();
//                                               cmobilecontroller.clear();

//                                               showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return AlertDialog(
//                                                       backgroundColor: AppColors
//                                                           .backgroundButton,
//                                                       content: TypoText(
//                                                               text:
//                                                                   "Mobile Incorrect",
//                                                               color: AppColors
//                                                                   .colorTextInput)
//                                                           .longCast(),
//                                                     );
//                                                   });
//                                             }
//                                           }
//                                         },
//                                         child: TypoText(
//                                                 text: AppLocalizations.of(
//                                                         context)!
//                                                     .step,
//                                                 color: AppColors.background)
//                                             .h2(),
//                                         color: AppColors.backgroundButton),
//                                   ],
//                                 )
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         bottomSheet: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Container(
//             height: 5,
//             width: double.infinity,
//             decoration: BoxDecoration(color: AppColors.red),
//           ),
//         ),
//       ),
//     );
//   }

//   hideSnackBar(BuildContext context) => ScaffoldMessenger.of(context)
//       .hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);

//   showSnackBar(BuildContext context, String text, int duration) =>
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           backgroundColor: AppColors.backgroundButton,
//           duration: Duration(seconds: duration),
//           content: TypoText(text: text, color: Colors.white).h3()));
// }

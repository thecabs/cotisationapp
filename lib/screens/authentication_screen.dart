import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/screens/main_screen.dart';
import 'package:gpt/utils/app_colors.dart';

import '../blocs/auth/authentication_bloc.dart';
import '../components/button_component.dart';
import '../utils/typography.dart';

class AuthenticationScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var bank_name = "";

    return BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthenticationOnLoadNameBank()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {

            if (state is AuthenticationLoadName) {
              bank_name = state.bankName;
            }

            if (state is AuthenticationOnLoginError) {
              hideSnackBar(context);
              showSnackBar(context,
                  AppLocalizations.of(context)!.authentication_error, 2);
            }

            if (state is AuthenticationOnLoginSuccess) {
              hideSnackBar(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(userModel: state.userModel)),
                  (route) => false);
              /*showSnackBar(context,
                  AppLocalizations.of(context)!.authentication_success, 2);*/
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: TypoText(
                            text: bank_name,
                            color: AppColors.colorTextInput)
                        .large(),
                  ),
                  TypoText(
                          text: AppLocalizations.of(context)!
                              .authentication_more_app,
                          color: AppColors.colorTextLong)
                      .long(),
                  const SizedBox(height: 20.0),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: usernameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: AppLocalizations.of(context)!.username,
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.empty_input;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            hintText: AppLocalizations.of(context)!.password,
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.empty_input;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            return ButtonComponent(
                              onPressed: (state is AuthenticationOnLoginWait)
                                  ? () {}
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(
                                                AuthenticationOnLoginEvent(
                                                    username: usernameController
                                                        .text
                                                        .trim(),
                                                    password: passwordController
                                                        .text
                                                        .trim()));
                                      }
                                    },
                              color: AppColors.backgroundButton,
                              child: TypoText(
                                      text: (state is AuthenticationOnLoginWait)
                                          ? AppLocalizations.of(context)!
                                              .loading
                                          : AppLocalizations.of(context)!
                                              .connection,
                                      color: AppColors.colorTextWhite)
                                  .h2(),
                            );
                          },
                        )
                      ],
                    ),
                  )
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
          content: TypoText(text: text, color: AppColors.colorTextWhite).h3()));
}

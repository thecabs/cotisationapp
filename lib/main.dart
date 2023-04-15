// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/screens/first_screen.dart';
import 'package:gpt/services/user_service.dart';
import 'package:gpt/utils/app_colors.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.background, // navigation bar color
    statusBarColor: AppColors.background, // status bar color
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app cotisation',
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
          useMaterial3: true,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: AppColors.background,
              surfaceTintColor: AppColors.background),
          colorSchemeSeed: AppColors.backgroundButton,
          scaffoldBackgroundColor: AppColors.background),
      home: MultiRepositoryProvider(
        providers: [RepositoryProvider(create: (context) => UserService())],
        child: FirstScreen(),
      ),
    );
  }
}

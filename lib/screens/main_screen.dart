import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/screens/addclient_step1_screen.dart';
import 'package:gpt/screens/client_screen.dart';
import 'package:gpt/screens/clientcamera_screen.dart';
import 'package:gpt/screens/cotisation_screen.dart';
import 'package:gpt/screens/search_screen.dart';
import 'package:gpt/screens/stepper.dart';

import '../models/user_model.dart';
import '../utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  final UserModel userModel;

  const MainScreen({super.key, required this.userModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //
    List body = [
      CotisationScreen(userModel: widget.userModel),
      SearchScreen(userModel: widget.userModel),
      //AddClientStep1Screen(),
      //CheckoutPage(),
      //AddClientView(userModel: widget.userModel),
      ClientScreen(userModel: widget.userModel),
      Camera()
    ];

    return Scaffold(
      body: SafeArea(
        child: body.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          setState(() {
            currentIndex = index;
          });
        },
        elevation: 0,
        currentIndex: currentIndex,
        backgroundColor: AppColors.background,
        selectedIconTheme:
            IconThemeData(color: AppColors.backgroundButton, size: 32),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: const IconThemeData(color: Colors.grey, size: 32),
        selectedLabelStyle:
            GoogleFonts.inter(color: AppColors.backgroundButton),
        unselectedLabelStyle: GoogleFonts.inter(color: Colors.white),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.wallet),
              label: AppLocalizations.of(context)!.cotisation),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: AppLocalizations.of(context)!.search),
          BottomNavigationBarItem(
              icon: const Icon(Icons.group),
              label: AppLocalizations.of(context)!.client),
          BottomNavigationBarItem(
              icon: const Icon(Icons.camera_front),
              label: AppLocalizations.of(context)!.client)
        ],
      ),
    );
  }
}

/* 

NavigationBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        selectedIndex: currentIndex,
        animationDuration: const Duration(seconds: 2),
        onDestinationSelected: (index) async {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: <NavigationDestination>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.home_rounded),
            icon: const Icon(Icons.home_rounded),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            // ignore: deprecated_member_use
            selectedIcon: const Icon(Icons.search),
            // ignore: deprecated_member_use
            icon: const Icon(Icons.search),
            label: AppLocalizations.of(context)!.search,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.account_balance_wallet_rounded),
            icon: const Icon(Icons.account_balance_wallet_rounded),
            label: AppLocalizations.of(context)!.cotisation,
          ),
        ],
      ),

*/

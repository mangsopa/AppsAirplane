import 'package:airplaneapps/cubit/page_cubit.dart';
import 'package:airplaneapps/ui/pages/home_page.dart';
import 'package:airplaneapps/ui/pages/settings_page.dart';
import 'package:airplaneapps/ui/pages/transaction_page.dart';
import 'package:airplaneapps/ui/pages/wallet_page.dart';
import 'package:airplaneapps/ui/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return TransactionPage();
        case 2:
          return WalletPage();
        case 3:
          return SettingsPage();
        default:
          return HomePage();
      }
    }

    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(
            bottom: 30,
            left: defaultMargin,
            right: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomNavigation(
                index: 0,
                imageUrl: 'assets/icon_home.png',
              ),
              CustomNavigation(index: 1, imageUrl: 'assets/icon_book.png'),
              CustomNavigation(index: 2, imageUrl: 'assets/icon_card.png'),
              CustomNavigation(index: 3, imageUrl: 'assets/icon_settings.png'),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              buildContent(currentIndex),
              customBottomNavigation(),
            ],
          ),
        );
      },
    );
  }
}

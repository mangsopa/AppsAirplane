import 'package:airplaneapps/cubit/auth_cubit.dart';
import 'package:airplaneapps/cubit/destination_cubit.dart';
import 'package:airplaneapps/cubit/page_cubit.dart';
import 'package:airplaneapps/cubit/seat_cubit.dart';
import 'package:airplaneapps/cubit/transaction_cubit.dart';
import 'package:airplaneapps/firebase_options.dart';
import 'package:airplaneapps/ui/pages/bonus_page.dart';
import 'package:airplaneapps/ui/pages/login_page.dart';
import 'package:airplaneapps/ui/pages/main_page.dart';
import 'package:airplaneapps/ui/pages/register_page.dart';
import 'package:airplaneapps/ui/pages/started_page.dart';
import 'package:airplaneapps/ui/pages/splash_page.dart';
import 'package:airplaneapps/ui/pages/success_checkout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => DestinationCubit(),
        ),
        BlocProvider(
          create: (context) => SeatCubit(),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/get-started': (context) => StartedPage(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
          '/bonus': (context) => BonusPage(),
          '/main': (context) => MainPage(),
          '/success': (context) => SuccessCheckout(),
        },
      ),
    );
  }
}

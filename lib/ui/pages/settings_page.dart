import 'package:airplaneapps/cubit/auth_cubit.dart';
import 'package:airplaneapps/cubit/page_cubit.dart';
import 'package:airplaneapps/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kRedColor,
            content: Text(state.message),
          ),
        );
      } else if (state is AuthInitial) {
        context.read<PageCubit>().setPage(0);
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }, builder: (context, state) {
      if (state is AuthLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Center(
        child: CustomButton(
          title: 'Sign Out',
          onPresed: () {
            context.read<AuthCubit>().signOut();
          },
          width: 220,
        ),
      );
    });
  }
}

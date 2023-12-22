import 'package:airplaneapps/cubit/auth_cubit.dart';
import 'package:airplaneapps/ui/widgets/custom_button.dart';
import 'package:airplaneapps/ui/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController hobbyController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Join us and get\nyour next journey',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semibold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomFormField(
          title: 'Full Name',
          hintText: 'Your Full Name',
          controller: nameController,
        );
      }

      Widget emailInput() {
        return CustomFormField(
          title: 'Email Address',
          hintText: 'Your Email Address',
          controller: emailController,
        );
      }

      Widget passwordInput() {
        return CustomFormField(
          title: 'Password',
          hintText: 'Your Password',
          obscureText: true,
          controller: passwordController,
        );
      }

      Widget hobbyInput() {
        return CustomFormField(
          title: 'Hobby',
          hintText: 'Your Hobby',
          controller: hobbyController,
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/bonus', (route) => false);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kRedColor,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomButton(
              margin: EdgeInsets.only(top: 30),
              title: 'Get Started',
              onPresed: () {
                context.read<AuthCubit>().register(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                    hobby: hobbyController.text);
              },
            );
          },
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        child: Column(children: [
          nameInput(),
          emailInput(),
          passwordInput(),
          hobbyInput(),
          submitButton()
        ]),
      );
    }

    Widget loginButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 50,
            bottom: 73,
          ),
          child: Text(
            'Sudah punya akun? Login Disini',
            style: greenTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            title(),
            inputSection(),
            loginButton(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_api/core/manager/app_colors.dart';
import 'package:products_api/core/shared/components/only_email_text_field.dart';
import 'package:products_api/core/shared/components/password_text_field.dart';
import 'package:products_api/features/login/cubit/login_cubit.dart';
import 'package:products_api/features/products/products_screen.dart';
import 'package:products_api/features/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // text controllers
  final _emailController = TextEditingController(text: "boda@gmail.com");
  final _passwordController = TextEditingController(text: "123123123");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bg,
        appBar: AppBar(
          backgroundColor: AppColors.bg,
          elevation: 0,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text(
            "Login",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Gap(30),
                OnlyEmailTextField(
                  controller: _emailController,
                  hint: "Enter your email",
                  icon: Icons.mail_outline_outlined,
                ),
                SizedBox(height: 20),
                PasswordTextField(
                  controller: _passwordController,
                  hint: "Enter your password",
                  icon: Icons.lock_outlined,
                ),
                Gap(10),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(30),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (c) => ProductsScreen()),
                      );
                    }
                    if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final LoginCubit cubit = context.read<LoginCubit>();
                    return GestureDetector(
                      onTap: () {
                        if (!_formKey.currentState!.validate()) return;
                        cubit.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 350,
                        decoration: BoxDecoration(
                          color: state is! LoginLoading
                              ? AppColors.primary
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: state is LoginLoading
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      ),
                      child: Text(
                        " Sign Up",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

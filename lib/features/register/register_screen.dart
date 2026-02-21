import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:products_api/core/manager/app_colors.dart';
import 'package:products_api/core/shared/components/en_text_field.dart';
import 'package:products_api/core/shared/components/numbers_text_feidel.dart';
import 'package:products_api/core/shared/components/only_email_text_field.dart';
import 'package:products_api/core/shared/components/password_text_field.dart';
import 'package:products_api/features/login/cubit/login_cubit.dart';
import 'package:products_api/features/products/products_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String gender = "male";
  // form key
  final _formKey = GlobalKey<FormState>();

  // text controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationdalIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _nationdalIdController.dispose();
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
            "Sign Up",
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
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/profile.png"),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: -12,
                        right: -10,
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.bg,
                            foregroundColor: AppColors.primary,
                            // side: BorderSide(color: AppColors.primary2),
                            iconSize: 20,
                          ),
                          icon: const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(30),
                OnlyEngTextField(
                  controller: _nameController,
                  hint: "Enter your name",
                  icon: Icons.abc,
                ),
                Gap(20),
                OnlyNumTextField(
                  controller: _phoneController,
                  hint: "Enter your phone number",
                  icon: Icons.phone,
                ),
                Gap(20),
                OnlyNumTextField(
                  controller: _nationdalIdController,
                  hint: "Enter your nationdal id",
                  icon: Icons.card_membership_outlined,
                ),
                Gap(20),
                SizedBox(
                  height: 55,
                  child: DropdownButtonFormField(
                    dropdownColor: AppColors.bg2,
                    decoration: InputDecoration(
                      label: Text(
                        "Select Gender",
                        style: TextStyle(fontSize: 13),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 73, 73, 73),
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Color(0xffF2F2F2),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "male",
                        child: Text(
                          "Male",
                          style: TextStyle(fontSize: 13, color: AppColors.text),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "female",
                        child: Text(
                          "Female",
                          style: TextStyle(fontSize: 13, color: AppColors.text),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
                Gap(20),
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
                        cubit.signUp(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          phone: _phoneController.text.trim(),
                          nationalId: _nationdalIdController.text.trim(),
                          gender: gender,
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
                                "Sign Up",
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

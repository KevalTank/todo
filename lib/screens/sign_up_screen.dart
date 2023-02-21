// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/custom_widgets/custom_text_field.dart';
import 'package:todo/custom_widgets/validators.dart';
import 'package:todo/models/user.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _todoRepository = TodoRepository();
  User _user = const User();
  bool loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        _user = await _todoRepository.signUpWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (_user != User.empty) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter your name',
                  validator: requiredValidator,
                ),
                SizedBox(height: 2.h),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  validator: validateEmail,
                ),
                SizedBox(height: 2.h),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Create a password',
                  validator: validatePassword,
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 5.5.h,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Sign Up'),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        // navigate to login screen
                      },
                      child: const Text('Log in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

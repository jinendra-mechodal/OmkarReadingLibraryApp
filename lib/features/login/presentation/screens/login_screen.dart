import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../data/app_excaption.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../../data/login_repository.dart';
import '../../view_models/login_usecase.dart';
import '../widgets/login_button.dart';
import '../widgets/login_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
      logDebug('Password visibility toggled. Obscure: $_obscurePassword');
    });
  }

  // void _login() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     final email = _emailController.text;
  //     final password = _passwordController.text;
  //
  //     logDebug('Login button pressed');
  //     logDebug('Email: $email');
  //     logDebug('Password: $password');
  //
  //     final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
  //     loginViewModel.login(email, password).then((_) {
  //       if (loginViewModel.errorMessage == null) {
  //         logDebug('Login successful. Navigating to Home page');
  //         Navigator.pushNamed(context, AppRoutes.home);
  //       } else {
  //         logDebug('Login failed: ${loginViewModel.errorMessage}');
  //       }
  //     }).catchError((error) {
  //       logDebug('Login error: $error');
  //     });
  //   } else {
  //     logDebug('Form validation failed');
  //   }
  // }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;

      logDebug('Login button pressed');
      logDebug('Email: $email');
      logDebug('Password: $password');

      final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

      loginViewModel.login(email, password, context).then((_) {
        final route = loginViewModel.navigationRoute;
        if (route != null) {
          logDebug('Navigating to: $route');
          Navigator.pushNamedAndRemoveUntil(
            context,
            route,
                (Route<dynamic> route) => false,
          );
        }
      }).catchError((error) {
        logDebug('Login error: $error');

        // Use Utils to display the error message to the user
        if (error is AppExceptions) {
         // Utils.snackBar('Login Error', error.toString());
          Utils.snackBar('',error.toString());
        } else {
          Utils.snackBar('Unexpected Error', 'An unexpected error occurred: $error');
        }

      });
    } else {
      logDebug('Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(AuthRepository()),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.whiteColor,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      Image.asset("assets/images/login-img.png"),
                      SizedBox(height: 20.h),
                      Text(
                        "Welcome Back!",
                        style: LexendtextFont500.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Sign in to your account using your ID and Password",
                        style: LexendtextFont300.copyWith(
                          fontSize: 13.sp,
                          color: AppColor.textcolorSilver,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoginTextFormField(
                              controller: _emailController,
                              hintText: 'User ID',
                              focusNode: _emailFocusNode,
                              onFieldSubmittedCallback: () {
                                // Move focus to the next field (password)
                                Utils.fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
                              },
                              validator: (value) {
                                logDebug('Validating email: $value');
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            LoginTextFormField(
                              controller: _passwordController,
                              hintText: 'Password',
                              obscureText: _obscurePassword,
                              focusNode: _passwordFocusNode,
                              toggleObscureText: _togglePasswordVisibility,
                              validator: (value) {
                                logDebug('Validating password: $value');
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),

                            viewModel.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : LoginButton(onPressed: _login),
                            if (viewModel.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  viewModel.errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

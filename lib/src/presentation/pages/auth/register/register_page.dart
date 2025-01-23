import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Update validation variables
  bool _isNameValid = false;
  bool _isUsernameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  String _password = '';
  String _confirmPassword = '';

  // Add validation methods
  void _validateName(String value) {
    setState(() {
      _isNameValid = value.length >= 2;
    });
  }

  void _validateUsername(String value) {
    setState(() {
      _isUsernameValid = value.length >= 3;
    });
  }

  void _validateEmail(String value) {
    setState(() {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      _isEmailValid = emailRegex.hasMatch(value);
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _password = value;
      _isPasswordValid = value.length >= 6;
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      _confirmPassword = value;
      _isConfirmPasswordValid = value == _password;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(

            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Name',
                    onChanged: _validateName,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    isError: !_isNameValid,
                    descriptionText: !_isNameValid ? 'Name must be at least 2 characters' : null,
                  ),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Username',
                    onChanged: _validateUsername,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    isError: !_isUsernameValid,
                    descriptionText: !_isUsernameValid ? 'Username must be at least 3 characters' : null,
                  ),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Your email',
                    onChanged: _validateEmail,
                    inputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    isError: !_isEmailValid,
                    descriptionText: !_isEmailValid ? 'Please enter a valid email' : null,
                  ),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Your password',
                    onChanged: _validatePassword,
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    textCapitalization: TextCapitalization.none,
                    isError: !_isPasswordValid,
                    descriptionText: !_isPasswordValid ? 'Password must be at least 6 characters' : null,
                  ),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Confirm password',
                    onChanged: _validateConfirmPassword,
                    inputType: TextInputType.visiblePassword,
                    obscureText: true,
                    textCapitalization: TextCapitalization.none,
                    isError: !_isConfirmPasswordValid,
                    descriptionText: !_isConfirmPasswordValid ? 'Passwords do not match' : null,
                  ),
                  const Spacer(),
                  Text(
                    'By registering, you accept our Terms of Use and Privacy Policy.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isEmailValid && _isPasswordValid && _isConfirmPasswordValid
                          ? () {
                              context.goNamed(RouteName.home);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.splashBackground,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        disabledBackgroundColor: Colors.grey[300],
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: _isEmailValid ? AppColors.black : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
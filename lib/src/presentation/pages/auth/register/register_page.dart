import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/pages/auth/register/riverpod/notifier/register_notifier.dart';
import 'package:wise/src/presentation/pages/auth/register/riverpod/provider/register_provider.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    
    final registerState = ref.watch(registerProvider);
    final registerNotifier = ref.watch(registerProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: registerState.isLoading ? const LoadingWidget() :  SingleChildScrollView(
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
                    textController: registerNotifier.nameController,
                    onChanged: registerNotifier.setName,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    isError: registerState.isNameInvalid,
                    descriptionText: registerState.isNameInvalid ? registerState.validationErrors['name'] : null,
                  ),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Username',
                    textController: registerNotifier.userNameController,
                    onChanged: registerNotifier.setUserName,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.none,
                    isError: registerState.isUserNameInvalid,
                    descriptionText: registerState.isUserNameInvalid ? registerState.validationErrors['userName'] : null,
                  ),
                  14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Your email',
                    textController: registerNotifier.emailController,
                    onChanged: registerNotifier.setEmail,
                    inputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    isError: registerState.isEmailInvalid,
                    descriptionText: registerState.isEmailInvalid ? registerState.validationErrors['email'] : null,
                  ),
                  14.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedBorderTextField(
                          textController: registerNotifier.passwordController,
                          obscure: registerState.showPassword,
                          label: 'Your password',
                          onChanged: registerNotifier.setPassword,
                          inputType: TextInputType.visiblePassword,
                          textCapitalization: TextCapitalization.none,
                          isError: registerState.isPasswordInvalid,
                        descriptionText: registerState.isPasswordInvalid ? registerState.validationErrors['password'] : null,
                      ),
                      ),
                      IconButton(
                        icon: registerState.showPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                        onPressed: () => registerNotifier.toggleShowPassword(),
                      ),
                    ],
                  ),
                  14.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedBorderTextField(
                          textController: registerNotifier.confirmPasswordController,
                          obscure: registerState.showConfirmPassword,
                          label: 'Confirm password',
                          onChanged: registerNotifier.setConfirmPassword,
                          inputType: TextInputType.visiblePassword,
                          textCapitalization: TextCapitalization.none,
                          isError: registerState.isConfirmPasswordInvalid,
                        descriptionText: registerState.isConfirmPasswordInvalid ? registerState.validationErrors['confirmPassword'] : null,
                      ),
                      ),
                      IconButton(
                        icon: registerState.showConfirmPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                        onPressed: () => registerNotifier.toggleShowConfirmPassword(),
                      ),
                    ],
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
                      onPressed: registerNotifier.isFormValid
                          ? () {
                              registerNotifier.register(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: registerNotifier.isFormValid ? AppColors.splashBackground : Colors.grey[300],
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
                              color: registerNotifier.isFormValid ? AppColors.black : Colors.grey[600],
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wise/src/core/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/core/router/route_name.dart';
import 'package:wise/src/presentation/pages/auth/login/riverpod/provider/login_provider.dart';
import 'package:wise/src/presentation/theme/app_colors.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.watch(loginProvider.notifier);
    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: loginState.isLoading ? const LoadingWidget() : SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
             context.canPop() ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ) : const SizedBox.shrink(),
              SizedBox(height: 24.h),
              Text(
                'Enter your email address',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  
                ),
              ),
              SizedBox(height: 24.h),
             14.verticalSpace,
                  OutlinedBorderTextField(
                    label: 'Your email',
                    textController: loginNotifier.emailController,
                    onChanged: loginNotifier.setEmail,
                    inputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    isError: loginState.isEmailNotValid,
                    descriptionText: loginState.isEmailNotValid ? loginState.validationErrors['email'] : null,
                  ),
                  14.verticalSpace,
                   OutlinedBorderTextField(
                    obscure: loginState.showPassword,
                    label: 'Your password',
                    textController: loginNotifier.passwordController,
                    onChanged: loginNotifier.setPassword,
                    inputType: TextInputType.visiblePassword,
                    textCapitalization: TextCapitalization.none,
                    isError: loginState.isPasswordNotValid,
                    descriptionText: loginState.isPasswordNotValid ? loginState.validationErrors['password'] : null,
                    suffixIcon: IconButton(
                      icon: loginState.showPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                      onPressed: loginNotifier.toggleShowPassword,
                    ),
                  ),
                  14.verticalSpace,
              const Spacer(),
              Text(
                'By registering, you accept our Terms of Use and Privacy Policy.',
                style: TextStyle(
                  fontSize: 14.sp,
                
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loginNotifier.isFormValid
                      ? () {
                          loginNotifier.login(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: loginState.isEmailNotValid ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primaryContainer,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    disabledBackgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: loginState.isEmailNotValid ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/presentation/pages/main/send_money/riverpod/provider/send_money_provider.dart';

class SendMoneyPage extends ConsumerStatefulWidget {
  const SendMoneyPage({super.key});

  @override
  ConsumerState<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends ConsumerState<SendMoneyPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sendMoneyNotifierProvider);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Send Money',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: state.isTransactionLoading || state.isLoadingUserDetails 
        ? const LoadingWidget() 
        : SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,
                  _buildBalanceCard(context),
                  32.verticalSpace,
                  _buildAmountInput(context),
                  32.verticalSpace,
                  _buildRecipientSection(context),
                  40.verticalSpace,
                  _buildSendButton(context),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final state = ref.watch(sendMoneyNotifierProvider);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            ),
          ),
          8.verticalSpace,
          Text(
            '\$${state.user?.balance?.toStringAsFixed(2) ?? '0.00'}',
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(BuildContext context) {
    final state = ref.watch(sendMoneyNotifierProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          ),
        ),
        16.verticalSpace,
        TextField(
          onChanged: ref.read(sendMoneyNotifierProvider.notifier).setAmount,
          controller: ref.read(sendMoneyNotifierProvider.notifier).amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          decoration: InputDecoration(
            errorText: state.isAmountInvalid ? state.validationErrors['amount'] : null,
            prefixText: '\$ ',
            prefixStyle: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            hintText: '0.00',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientSection(BuildContext context) {
    final state = ref.watch(sendMoneyNotifierProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient',
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          ),
        ),
        16.verticalSpace,
        TextField(
          controller: ref.read(sendMoneyNotifierProvider.notifier).emailController,
          onChanged: ref.read(sendMoneyNotifierProvider.notifier).setEmail,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          decoration: InputDecoration(
            hintText: 'Email address',
            errorText: state.isEmailNotValid ? state.validationErrors['email'] : null,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final isFormValid = ref.watch(sendMoneyNotifierProvider.notifier).isFormValid;
    
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isFormValid 
          ? () => ref.read(sendMoneyNotifierProvider.notifier).sendMoney(context, ref) 
          : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        child: Text(
          'Send Money',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
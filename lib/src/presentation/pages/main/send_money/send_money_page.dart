import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wise/src/core/presentation/components/text_fields/outline_bordered_text_field.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: state.isTransactionLoading || state.isLoadingUserDetails ? const LoadingWidget() : CustomScrollView(
        slivers: [
          // App Bar
         const AppBar(),

          // Content
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Current Balance Card
                  _buildBalanceCard(context, ref),
                  SizedBox(height: 24.h),

                  // Amount Input Section
                  _buildAmountInput(context, ref  ),
                  SizedBox(height: 24.h),

                  // Recipient Section
                  _buildRecipientSection(context, ref),
                  
                  const Spacer(),

                  // Send Button
                  _buildSendButton(context),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendMoneyNotifierProvider);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Balance',
            style: TextStyle(
              fontSize: 16.sp,
              letterSpacing: 0.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            state.user?.balance.toString() ?? 'Unknown',
            style: GoogleFonts.inter(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendMoneyNotifierProvider);
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            onChanged: ref.read(sendMoneyNotifierProvider.notifier).setAmount,
            controller: ref.read(sendMoneyNotifierProvider.notifier).amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.inter(
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              height: 1.1,
            ),
            decoration: InputDecoration(
              errorText: state.isAmountInvalid ? state.validationErrors['amount'] : null,
              prefixText: '\$ ',
              prefixStyle: GoogleFonts.inter(
                fontSize: 40.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                height: 1.1,
              ),
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientSection(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendMoneyNotifierProvider);
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipient',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 16.h),
          OutlinedBorderTextField(
            label: 'Email address',
            textController: ref.read(sendMoneyNotifierProvider.notifier).emailController,
            onChanged: ref.read(sendMoneyNotifierProvider.notifier).setEmail,
            inputType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            isError: state.isEmailNotValid,
            descriptionText: state.isEmailNotValid ? state.validationErrors['email'] : null,
            suffixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final state = ref.watch(sendMoneyNotifierProvider);
    final isFormValid = ref.watch(sendMoneyNotifierProvider.notifier).isFormValid;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: isFormValid ? () => ref.read(sendMoneyNotifierProvider.notifier).sendMoney(context, ref) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            disabledForegroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          child: Text(
            'Send Money',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      pinned: true,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        titlePadding: EdgeInsets.only(left: 24.w, bottom: 20.h),
        title: Text(
          'Send Money',
          style: GoogleFonts.inter(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
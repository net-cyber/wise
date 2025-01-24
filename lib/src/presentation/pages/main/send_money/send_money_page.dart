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
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                 
                  SizedBox(width: 8.w),
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  ' Account',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          Text(
            state.user?.balance.toString() ?? 'Unknown',
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Icon(
                Icons.currency_exchange,
                size: 20.sp,
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextField(
            
            onChanged: ref.read(sendMoneyNotifierProvider.notifier).setAmount,
            controller: ref.read(sendMoneyNotifierProvider.notifier).amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.inter(
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            decoration: InputDecoration(
              errorText: state.isAmountInvalid ? state.validationErrors['amount'] : null,
              prefixText: '\$ ',
              prefixStyle: GoogleFonts.inter(
                fontSize: 40.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
              ),
            
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientSection(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sendMoneyNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
         OutlinedBorderTextField(
                    label: 'Your email',
                    textController: ref.read(sendMoneyNotifierProvider.notifier).emailController,
                    onChanged: ref.read(sendMoneyNotifierProvider.notifier).setEmail,
                    inputType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    isError: state.isEmailNotValid,
                    descriptionText: state.isEmailNotValid ? state.validationErrors['email'] : null,
                    suffixIcon: const Icon(Icons.email),
                  ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    final state = ref.watch(sendMoneyNotifierProvider);
    final isFormValid = ref.watch(sendMoneyNotifierProvider.notifier).isFormValid;
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isFormValid ? () => ref.read(sendMoneyNotifierProvider.notifier).sendMoney(context, ref) : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: isFormValid ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.5),
            foregroundColor: isFormValid ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.r),
          ),
        ),
        child:Text(
                'Send Money',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              )
           
      ),
    );
  }

}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      pinned: true,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        titlePadding: EdgeInsets.only(left: 16.w, bottom: 16.h),
        title: Text(
          'Send Money',
          style: GoogleFonts.inter(
            fontSize: 34.sp,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
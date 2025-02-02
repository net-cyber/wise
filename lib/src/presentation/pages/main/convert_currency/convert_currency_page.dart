import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/provider/convert_currency_provider.dart';

class ConvertCurrencyPage extends ConsumerStatefulWidget {
  const ConvertCurrencyPage({super.key});

  @override
  ConsumerState<ConvertCurrencyPage> createState() => _ConvertCurrencyPageState();
}

class _ConvertCurrencyPageState extends ConsumerState<ConvertCurrencyPage> {

  @override
  Widget build(BuildContext context) {
    final amountNotifier = ref.watch(convertCurrencyProvider.notifier);
    final state = ref.watch(convertCurrencyProvider);
    
    return Scaffold(
      body: SafeArea(
        child: state.isLoadingCurrency || state.isConvertingCurrency
          ? const LoadingWidget()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.verticalSpace,
                  Text(
                    '💱 Currency Converter',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  30.verticalSpace,
                  _buildCurrencyCard(
                    isFrom: true,
                    controller: amountNotifier.amountController,
                    currencyCode: state.fromCurrency.isNotEmpty 
                      ? state.fromCurrency 
                      : state.exchangeRates.first.currencyCode,
                    exchangeRates: state.exchangeRates,
                  ),
                  20.verticalSpace,
                  Center(
                    child: IconButton(
                      onPressed: () {
                        // Add currency swap functionality here
                      },
                      icon: const Icon(Icons.swap_vert_rounded, size: 32),
                    ),
                  ),
                  20.verticalSpace,
                  _buildCurrencyCard(
                    isFrom: false,
                    controller: amountNotifier.amountController,
                    currencyCode: state.toCurrency.isNotEmpty 
                      ? state.toCurrency 
                      : state.exchangeRates.first.currencyCode,
                    exchangeRates: state.exchangeRates,
                  ),
                  24.verticalSpace,
                  if (state.currencyConversion != null)
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.currencyConversion?.convertedAmount.toStringAsFixed(2)} ${state.toCurrency}',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: ElevatedButton(
                      onPressed: amountNotifier.isFormValid
                          ? () => amountNotifier.convertCurrency(
                              fromCurrency: state.fromCurrency,
                              toCurrency: state.toCurrency,
                            )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: Size(double.infinity, 56.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Convert',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildCurrencyCard({
    required bool isFrom,
    required TextEditingController controller,
    required String currencyCode,
    required List<ExchangeRateResponse> exchangeRates,
  }) {
    final state = ref.watch(convertCurrencyProvider);
    
    String getFlagEmoji(String countryCode) {
      if (countryCode.length < 2) return '';
      final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
      final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
      return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isFrom ? 'From' : 'To',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: isFrom
                    ? TextField(
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 24.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        onChanged: (value) => ref.read(convertCurrencyProvider.notifier).setAmount(value),
                      )
                    : Text(
                        state.currencyConversion?.convertedAmount.toStringAsFixed(2) ?? '0.00',
                        style: TextStyle(fontSize: 24.sp),
                      ),
              ),
              GestureDetector(
                onTap: () async {
                  final selectedCurrency = await _showCurrencyPicker(context, exchangeRates);
                  if (selectedCurrency != null) {
                    ref.read(convertCurrencyProvider.notifier)
                        .updateSelectedCurrency(selectedCurrency, isFrom);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        getFlagEmoji(currencyCode.substring(0, 2)),
                        style: const TextStyle(fontSize: 20),
                      ),
                      8.horizontalSpace,
                      Text(
                        currencyCode,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      8.horizontalSpace,
                      const Icon(Icons.keyboard_arrow_down, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<ExchangeRateResponse?> _showCurrencyPicker(BuildContext context, List<ExchangeRateResponse> exchangeRates) {
    String getFlagEmoji(String countryCode) {
      final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
      final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
      return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
    }

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Currency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: exchangeRates.length,
                  itemBuilder: (context, index) {
                    final currency = exchangeRates[index];
                    return ListTile(
                      leading: Text(
                        getFlagEmoji(currency.currencyCode.substring(0, 2)),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(currency.currencyCode),
                      subtitle: Text(currency.name),
                      onTap: () {
                        Navigator.pop(context, currency);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
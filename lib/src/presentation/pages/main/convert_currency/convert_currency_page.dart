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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:state.isLoadingCurrency || state.isConvertingCurrency ?
           const LoadingWidget():
           SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How much do you want\nto convert?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  25.verticalSpace,
                  const Text(
                    'Convert',
                    style: TextStyle(
                      fontSize: 16,
                      
                    ),
                  ),
                  25.verticalSpace,
                  const Text(
                    'From',
                    style: TextStyle(
                      fontSize: 16,
                      
                    ),
                  ),
                  5.verticalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildCurrencyInput(
                        controller: amountNotifier.amountController,
                        amount: '',
                        currencyCode: state.fromCurrency.isNotEmpty 
                          ? state.fromCurrency 
                          : state.exchangeRates.first.currencyCode,
                        flag: (state.fromCurrency.isNotEmpty 
                          ? state.fromCurrency 
                          : state.exchangeRates.first.currencyCode).substring(0, 2),
                        exchangeRates: state.exchangeRates,
                        isFromCurrency: true,
                      ),
                    ],
                  ),
                  25.verticalSpace,
                  const SizedBox(height: 24),
                  const Text(
                    'To',
                    style: TextStyle(
                      fontSize: 16,
                    
                    ),
                  ),
                  5.verticalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCurrencyInput(
                        controller: amountNotifier.amountController,
                        amount: '',
                        currencyCode: state.toCurrency.isNotEmpty 
                          ? state.toCurrency 
                          : state.exchangeRates.first.currencyCode,
                        flag: (state.toCurrency.isNotEmpty 
                          ? state.toCurrency 
                          : state.exchangeRates.first.currencyCode).substring(0, 2),
                        exchangeRates: state.exchangeRates,
                        isFromCurrency: false,
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50.h,
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(state.currencyConversion?.convertedAmount.toString() ?? '',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  25.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      // Handle conversion
                      amountNotifier.convertCurrency(
                        fromCurrency: state.fromCurrency,
                        toCurrency: state.toCurrency,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9DE1A7),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }

  Widget _buildCurrencyInput({
    required TextEditingController controller,
    required String amount,
    required String currencyCode,
    required String flag,
    required List<ExchangeRateResponse> exchangeRates,
    required bool isFromCurrency,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Amount Input Field - Only show for "From" currency
        if (isFromCurrency)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              enabled: isFromCurrency,
              style: const TextStyle(fontSize: 24),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0.00',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              onChanged: (value) {
                final amountNotifier = ref.read(convertCurrencyProvider.notifier);
                amountNotifier.setAmount(value);
              },
            ),
          ),
        
        if (isFromCurrency) const SizedBox(height: 12),
        
        // Currency Dropdown
        GestureDetector(
          onTap: () async {
            final selectedCurrency = await _showCurrencyPicker(context, exchangeRates);
            if (selectedCurrency != null) {
              final amountNotifier = ref.read(convertCurrencyProvider.notifier);
              amountNotifier.updateSelectedCurrency(selectedCurrency, isFromCurrency);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(flag),
                    const SizedBox(width: 8),
                    Text(
                      currencyCode,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

 
  Future<ExchangeRateResponse?> _showCurrencyPicker(BuildContext context, List<ExchangeRateResponse> exchangeRates) {
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
                        currency.currencyCode.substring(0, 2),
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(currency.currencyCode),
                      subtitle: Text(currency.name),
                      onTap: () {
                        // Handle currency selection
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
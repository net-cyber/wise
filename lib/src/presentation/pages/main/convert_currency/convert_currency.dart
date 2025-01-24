import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wise/src/core/presentation/widgets/loading.dart';
import 'package:wise/src/model/exchage_rate_response.dart';
import 'package:wise/src/presentation/pages/main/convert_currency/riverpod/provider/convert_currency_provider.dart';
import 'package:wise/src/presentation/pages/main/home/home_page.dart';

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
                 _buildCurrencyInput(
                    controller: amountNotifier.amountController,
                    currencyCode: state.fromCurrency.isNotEmpty 
                      ? state.fromCurrency 
                      : state.exchangeRates.first.currencyCode,
                    flag: (state.fromCurrency.isNotEmpty 
                      ? state.fromCurrency 
                      : state.exchangeRates.first.currencyCode).substring(0, 2),
                    showDropdown: true,
                    exchangeRates: state.exchangeRates,
                    isFromCurrency: true,
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
                  _buildCurrencyInput(
                    controller: amountNotifier.amountController,
                    currencyCode: state.toCurrency.isNotEmpty 
                      ? state.toCurrency 
                      : state.exchangeRates.first.currencyCode,
                    flag: (state.toCurrency.isNotEmpty 
                      ? state.toCurrency 
                      : state.exchangeRates.first.currencyCode).substring(0, 2),
                    showDropdown: true,
                    exchangeRates: state.exchangeRates,
                    isFromCurrency: false,
                  ),
                  25.verticalSpace,
                  // _buildAutoConvertSection(),
                  25.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      // Handle conversion
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
    required String currencyCode,
    required String flag,
    bool showDropdown = false,
    required List<ExchangeRateResponse> exchangeRates,
    required bool isFromCurrency,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
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
            ),
          ),
          GestureDetector(
            onTap: showDropdown ? () async {
              final selectedCurrency = await _showCurrencyPicker(context, exchangeRates);
              if (selectedCurrency != null) {
                final amountNotifier = ref.read(convertCurrencyProvider.notifier);
                // Update the selected currency in your state
                // You'll need to add a method in your notifier to handle this
                amountNotifier.updateSelectedCurrency(selectedCurrency, isFromCurrency);
              }
            } : null,
            child: Row(
              children: [
                Text(flag),
                const SizedBox(width: 8),
                Text(
                  currencyCode,
                  style: const TextStyle(fontSize: 18),
                ),
                if (showDropdown) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ],
            ),
          ),
        ],
      ),
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
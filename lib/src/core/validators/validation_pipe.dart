import 'package:wise/src/core/validators/base_validator.dart';

class ValidationPipe<T> {
  final List<BaseValidator<T>> validators;

  ValidationPipe(this.validators);

  ValidationResult validate(T value) {
    for (final validator in validators) {
      final error = validator.validate(value);
      if (error != null) {
        return ValidationResult(isValid: false, error: error);
      }
    }
    return ValidationResult(isValid: true);
  }
}

class ValidationResult {
  final bool isValid;
  final String? error;

  ValidationResult({required this.isValid, this.error});
}
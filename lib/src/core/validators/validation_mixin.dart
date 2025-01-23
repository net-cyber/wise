import 'package:wise/src/core/validators/validation_pipe.dart';

mixin ValidationMixin {
  final Map<String, ValidationPipe> _validationPipes = {};

  void addValidationPipe(String field, ValidationPipe pipe) {
    _validationPipes[field] = pipe;
  }

  ValidationResult validateField(String field, dynamic value) {
    final pipe = _validationPipes[field];
    if (pipe == null) {
      return ValidationResult(isValid: true);
    }
    return pipe.validate(value);
  }

  Map<String, String> validateAll(Map<String, dynamic> data) {
    final errors = <String, String>{};
    
    for (final entry in data.entries) {
      final result = validateField(entry.key, entry.value);
      if (!result.isValid && result.error != null) {
        errors[entry.key] = result.error!;
      }
    }
    
    return errors;
  }
}


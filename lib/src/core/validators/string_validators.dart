import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wise/src/core/validators/base_validator.dart';

class RequiredValidator extends BaseValidator<String> {
  @override
  String? validate(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}

class MustBeNumberValidator extends BaseValidator<String> {
  @override
  String? validate(String value) {
    
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'This field must be a number';
    }
    return null;
  }
}
class MinValueValidator extends BaseValidator<String> {
  final double minValue;

  MinValueValidator(this.minValue);

  @override
  String? validate(String value) {
    if (double.parse(value) < minValue) {
      return 'Minimum value should be $minValue';
    }
    return null;
  }
}

class MaxValueValidator extends BaseValidator<String> {
  final double maxValue;

  MaxValueValidator(this.maxValue);

  @override
  String? validate(String value) {
    if (double.parse(value) > maxValue) {
      return 'Maximum value should be $maxValue';
    }
    return null;
  }
}

class NumberValidator extends BaseValidator<String> {
  @override
  String? validate(String value) {
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'This field must be a number';
    }
    return null;
  }
}
 
class EmailValidator extends BaseValidator<String> {
  @override
  String? validate(String value) {
    if (value.isEmpty) return null; // Let RequiredValidator handle empty case
    
    // Check for @ symbol
    if (!value.contains('@')) {
      return 'Email must contain @ symbol';
    }

    // Check for basic structure
    final parts = value.split('@');
    if (parts.length != 2) {
      return 'Email must have exactly one @ symbol';
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    // Validate local part
    if (localPart.isEmpty) {
      return 'Username part before @ cannot be empty';
    }
    // if (!RegExp(r'^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+$').hasMatch(localPart)) {
    //   return 'Username part contains invalid characters';
    // }

    // Validate domain part
    if (domainPart.isEmpty) {
      return 'Domain part after @ cannot be empty';
    }
    if (!domainPart.contains('.')) {
      return 'Domain must contain at least one dot';
    }
    if (!RegExp(r'^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$').hasMatch(domainPart)) {
      return 'Domain part contains invalid characters';
    }

    return null;
  }

}


class MinLengthValidator extends BaseValidator<String> {
  final int minLength;

  MinLengthValidator(this.minLength);

  @override
  String? validate(String value) {
    if (value.length < minLength) {
      return 'Minimum length should be $minLength characters';
    }
    return null;
  }
}

class MatchValidator extends BaseValidator<String> {
  final String otherField;

  MatchValidator(this.otherField);

  @override
  String? validate(String value) {
    log('==> validate called with: $value');
    log('==> otherField called with: $otherField');

    if (value != otherField) {
      return 'Passwords do not match';
    }
    return null;
  }
}

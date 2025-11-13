import 'package:health_fitness_app/utils/constants.dart';

/// Utility class for input validation
class Validators {
  /// Validates email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.errorEmptyEmail;
    }

    // Basic email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppConstants.errorInvalidEmail;
    }

    return null; // Valid
  }

  /// Validates password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.errorEmptyPassword;
    }

    if (value.length < AppConstants.minPasswordLength) {
      return AppConstants.errorPasswordTooShort;
    }

    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must be less than ${AppConstants.maxPasswordLength} characters';
    }

    return null; // Valid
  }

  /// Validates name field
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppConstants.errorEmptyName;
    }

    if (value.length < AppConstants.minNameLength) {
      return 'Name must be at least ${AppConstants.minNameLength} characters';
    }

    if (value.length > AppConstants.maxNameLength) {
      return 'Name must be less than ${AppConstants.maxNameLength} characters';
    }

    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null; // Valid
  }

  /// Validates required field (not empty)
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  /// Validates numeric input
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }

    final number = double.tryParse(value);
    if (number == null) {
      return '$fieldName must be a valid number';
    }

    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }

  /// Validates height (in cm, reasonable range)
  static String? validateHeight(String? value) {
    final numericError = validateNumeric(value, 'Height');
    if (numericError != null) return numericError;

    final height = double.parse(value!);
    if (height < 50 || height > 300) {
      return 'Height must be between 50 and 300 cm';
    }

    return null;
  }

  /// Validates weight (in kg, reasonable range)
  static String? validateWeight(String? value) {
    final numericError = validateNumeric(value, 'Weight');
    if (numericError != null) return numericError;

    final weight = double.parse(value!);
    if (weight < 20 || weight > 500) {
      return 'Weight must be between 20 and 500 kg';
    }

    return null;
  }

  /// Validates calorie target
  static String? validateCalorieTarget(String? value) {
    final numericError = validateNumeric(value, 'Calorie target');
    if (numericError != null) return numericError;

    final calories = int.parse(value!);
    if (calories < 500 || calories > 10000) {
      return 'Calorie target must be between 500 and 10,000 kcal';
    }

    return null;
  }

  /// Validates login credentials (demo only)
  static bool validateLoginCredentials(String email, String password) {
    return email == AppConstants.demoEmail && password == AppConstants.demoPassword;
  }
}

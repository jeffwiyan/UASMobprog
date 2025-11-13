import 'package:flutter/material.dart';

/// App-wide constants for the Health & Fitness App
class AppConstants {
  // App Information
  static const String appName = 'Health & Fitness App';
  static const String appVersion = '1.0.0';

  // Shared Preferences Keys
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyHasOnboarded = 'hasOnboarded';
  static const String keyUserName = 'userName';
  static const String keyUserEmail = 'userEmail';
  static const String keyUserHeight = 'userHeight';
  static const String keyUserWeight = 'userWeight';
  static const String keyCalorieTarget = 'calorieTarget';
  static const String keyWeeklySteps = 'weeklySteps';
  static const String keyWeeklyCalories = 'weeklyCalories';
  static const String keyWeeklyWorkouts = 'weeklyWorkouts';

  // Route Names
  static const String routeSplash = '/';
  static const String routeLogin = '/login';
  static const String routeSignup = '/signup';
  static const String routeOnboarding = '/onboarding';
  static const String routeHome = '/home';
  static const String routeWorkoutDetail = '/workout_detail';

  // Timing Constants
  static const int splashDurationSeconds = 3;
  static const int pageTransitionDuration = 300;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 10.0;
  static const double cardElevation = 2.0;
  static const double buttonVerticalPadding = 15.0;

  // Validation Constants
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Activity Goals
  static const int defaultStepsGoal = 10000;
  static const double defaultDistanceGoal = 8.0; // km
  static const int defaultCaloriesGoal = 500;
  static const int defaultCalorieTarget = 2500;

  // Demo Credentials (for testing only - remove in production)
  static const String demoEmail = 'test@example.com';
  static const String demoPassword = 'password';

  // Colors
  static const Color primaryColor = Colors.teal;
  static const Color secondaryColor = Colors.tealAccent;
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;

  // Text Styles
  static const TextStyle headlineStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
  );

  // Error Messages
  static const String errorEmptyEmail = 'Email cannot be empty';
  static const String errorInvalidEmail = 'Please enter a valid email address';
  static const String errorEmptyPassword = 'Password cannot be empty';
  static const String errorPasswordTooShort = 'Password must be at least 6 characters';
  static const String errorEmptyName = 'Name cannot be empty';
  static const String errorInvalidCredentials = 'Invalid email or password';
  static const String errorGeneric = 'An error occurred. Please try again.';

  // Success Messages
  static const String successRegistration = 'Registration successful!';
  static const String successLogin = 'Login successful!';
  static const String successLogout = 'Logged out successfully';

  // Asset Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String pushupPath = 'assets/images/pushup.png';
  static const String squatPath = 'assets/images/squat.png';
  static const String yogaPath = 'assets/images/yoga.png';
  static const String runPath = 'assets/images/run.png';
  static const String dumbbellPath = 'assets/images/dumbbell.png';
}

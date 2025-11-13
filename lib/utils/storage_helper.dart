import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_fitness_app/utils/constants.dart';

/// Helper class for SharedPreferences operations with error handling
class StorageHelper {
  /// Get SharedPreferences instance with error handling
  static Future<SharedPreferences> _getPrefs() async {
    try {
      return await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception('Failed to access device storage: $e');
    }
  }

  /// Save boolean value
  static Future<bool> saveBool(String key, bool value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setBool(key, value);
    } catch (e) {
      print('Error saving bool $key: $e');
      return false;
    }
  }

  /// Get boolean value
  static Future<bool?> getBool(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getBool(key);
    } catch (e) {
      print('Error getting bool $key: $e');
      return null;
    }
  }

  /// Save string value
  static Future<bool> saveString(String key, String value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setString(key, value);
    } catch (e) {
      print('Error saving string $key: $e');
      return false;
    }
  }

  /// Get string value
  static Future<String?> getString(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getString(key);
    } catch (e) {
      print('Error getting string $key: $e');
      return null;
    }
  }

  /// Save integer value
  static Future<bool> saveInt(String key, int value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setInt(key, value);
    } catch (e) {
      print('Error saving int $key: $e');
      return false;
    }
  }

  /// Get integer value
  static Future<int?> getInt(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getInt(key);
    } catch (e) {
      print('Error getting int $key: $e');
      return null;
    }
  }

  /// Save double value
  static Future<bool> saveDouble(String key, double value) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setDouble(key, value);
    } catch (e) {
      print('Error saving double $key: $e');
      return false;
    }
  }

  /// Get double value
  static Future<double?> getDouble(String key) async {
    try {
      final prefs = await _getPrefs();
      return prefs.getDouble(key);
    } catch (e) {
      print('Error getting double $key: $e');
      return null;
    }
  }

  /// Remove a key
  static Future<bool> remove(String key) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.remove(key);
    } catch (e) {
      print('Error removing $key: $e');
      return false;
    }
  }

  /// Clear all data
  static Future<bool> clearAll() async {
    try {
      final prefs = await _getPrefs();
      return await prefs.clear();
    } catch (e) {
      print('Error clearing storage: $e');
      return false;
    }
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final isLoggedIn = await getBool(AppConstants.keyIsLoggedIn);
    return isLoggedIn ?? false;
  }

  /// Check if user has completed onboarding
  static Future<bool> hasOnboarded() async {
    final hasOnboarded = await getBool(AppConstants.keyHasOnboarded);
    return hasOnboarded ?? false;
  }

  /// Save user login state
  static Future<bool> setLoggedIn(bool loggedIn) async {
    return await saveBool(AppConstants.keyIsLoggedIn, loggedIn);
  }

  /// Save onboarding completion state
  static Future<bool> setOnboarded(bool onboarded) async {
    return await saveBool(AppConstants.keyHasOnboarded, onboarded);
  }

  /// Save user profile data
  static Future<bool> saveUserProfile({
    required String name,
    required String email,
    String? height,
    String? weight,
    int? calorieTarget,
  }) async {
    try {
      await saveString(AppConstants.keyUserName, name);
      await saveString(AppConstants.keyUserEmail, email);

      if (height != null) {
        await saveString(AppConstants.keyUserHeight, height);
      }
      if (weight != null) {
        await saveString(AppConstants.keyUserWeight, weight);
      }
      if (calorieTarget != null) {
        await saveInt(AppConstants.keyCalorieTarget, calorieTarget);
      }

      return true;
    } catch (e) {
      print('Error saving user profile: $e');
      return false;
    }
  }

  /// Get user profile data
  static Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final name = await getString(AppConstants.keyUserName);
      final email = await getString(AppConstants.keyUserEmail);
      final height = await getString(AppConstants.keyUserHeight);
      final weight = await getString(AppConstants.keyUserWeight);
      final calorieTarget = await getInt(AppConstants.keyCalorieTarget);

      return {
        'name': name ?? 'User',
        'email': email ?? '',
        'height': height ?? '175 cm',
        'weight': weight ?? '72 kg',
        'calorieTarget': calorieTarget ?? AppConstants.defaultCalorieTarget,
      };
    } catch (e) {
      print('Error getting user profile: $e');
      return {
        'name': 'User',
        'email': '',
        'height': '175 cm',
        'weight': '72 kg',
        'calorieTarget': AppConstants.defaultCalorieTarget,
      };
    }
  }

  /// Logout user (clear login state)
  static Future<bool> logout() async {
    try {
      return await setLoggedIn(false);
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }

  /// Save weekly progress data
  static Future<bool> saveWeeklyProgress({
    required int steps,
    required int calories,
    required int workouts,
  }) async {
    try {
      await saveInt(AppConstants.keyWeeklySteps, steps);
      await saveInt(AppConstants.keyWeeklyCalories, calories);
      await saveInt(AppConstants.keyWeeklyWorkouts, workouts);
      return true;
    } catch (e) {
      print('Error saving weekly progress: $e');
      return false;
    }
  }

  /// Get weekly progress data
  static Future<Map<String, int>> getWeeklyProgress() async {
    try {
      final steps = await getInt(AppConstants.keyWeeklySteps) ?? 0;
      final calories = await getInt(AppConstants.keyWeeklyCalories) ?? 0;
      final workouts = await getInt(AppConstants.keyWeeklyWorkouts) ?? 0;

      return {
        'steps': steps,
        'calories': calories,
        'workouts': workouts,
      };
    } catch (e) {
      print('Error getting weekly progress: $e');
      return {
        'steps': 0,
        'calories': 0,
        'workouts': 0,
      };
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_fitness_app/utils/constants.dart';
import 'package:health_fitness_app/utils/storage_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      // Check login status
      final isLoggedIn = await StorageHelper.isLoggedIn();
      final hasOnboarded = await StorageHelper.hasOnboarded();

      Timer(const Duration(seconds: AppConstants.splashDurationSeconds), () {
        if (!mounted) return;

        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, AppConstants.routeHome);
        } else if (hasOnboarded) {
          Navigator.pushReplacementNamed(context, AppConstants.routeLogin);
        } else {
          Navigator.pushReplacementNamed(context, AppConstants.routeOnboarding);
        }
      });
    } catch (e) {
      // If there's an error reading preferences, go to onboarding
      Timer(const Duration(seconds: AppConstants.splashDurationSeconds), () {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppConstants.routeOnboarding);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppConstants.logoPath,
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.fitness_center,
                  size: 150,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

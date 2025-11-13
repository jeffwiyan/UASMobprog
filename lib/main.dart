import 'package:flutter/material.dart';
import 'package:health_fitness_app/pages/splash_screen.dart';
import 'package:health_fitness_app/pages/home_page.dart';
import 'package:health_fitness_app/pages/login_page.dart';
import 'package:health_fitness_app/pages/signup_page.dart';
import 'package:health_fitness_app/pages/onboarding_page.dart';
import 'package:health_fitness_app/pages/workout_detail_page.dart';
import 'package:health_fitness_app/models/workout.dart';

void main() {
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health & Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/home': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/workout_detail') {
          final workout = settings.arguments as Workout;
          return MaterialPageRoute(
            builder: (context) => WorkoutDetailPage(workout: workout),
          );
        }
        return null;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:health_fitness_app/models/workout.dart';
import 'package:health_fitness_app/pages/workout_detail_page.dart';

class WorkoutListPage extends StatelessWidget {
  const WorkoutListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Workout data (using local images from assets/images)
    final workouts = [
      {
        'name': 'Push Up',
        'desc': 'Strengthens chest, shoulders, and triceps. Great for beginners.',
        'image': 'assets/images/pushup.png',
      },
      {
        'name': 'Sit Up',
        'desc': 'Targets abdominal muscles and improves core strength.',
        'image': 'assets/images/situp.png',
      },
      {
        'name': 'Plank',
        'desc': 'Builds core stability and overall body strength.',
        'image': 'assets/images/plank.png',
      },
      {
        'name': 'Squat',
        'desc': 'Strengthens legs, hips, and lower back muscles.',
        'image': 'assets/images/squat.png',
      },
      {
        'name': 'Yoga',
        'desc': 'Improves flexibility, balance, and mental well-being.',
        'image': 'assets/images/yoga.png',
      },
      {
        'name': 'Running',
        'desc': 'Boosts cardiovascular endurance and stamina.',
        'image': 'assets/images/run.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workout List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  workout['image']!,
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                workout['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                workout['desc']!,
                style: const TextStyle(fontSize: 13),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 18,
              ),
              onTap: () {
                // Create a Workout object from the map
                final workoutObj = Workout(
                  name: workout['name']!,
                  duration: '30', // Default duration
                  level: 'Beginner', // Default level
                  icon: Icons.fitness_center,
                  steps: ['Step 1: Follow the instructions', 'Step 2: Complete the workout'],
                );
                Navigator.pushNamed(
                  context,
                  '/workout_detail',
                  arguments: workoutObj,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

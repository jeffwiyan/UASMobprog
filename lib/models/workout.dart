import 'package:flutter/material.dart';

class Workout {
  final String name;
  final String duration;
  final String level;
  final IconData icon;
  final List<String> steps;

  Workout({
    required this.name,
    required this.duration,
    required this.level,
    required this.icon,
    required this.steps,
  });
}

final List<Workout> workoutList = [
  Workout(
    name: 'Abdominal Workout',
    duration: '10',
    level: 'Beginner',
    icon: Icons.fitness_center,
    steps: [
      'Warm-up (5 minutes)',
      'Crunches (3 sets x 15 reps)',
      'Plank (3 sets x 30 seconds)',
      'Leg Raises (3 sets x 15 reps)',
      'Cool-down (5 minutes)',
    ],
  ),
  Workout(
    name: 'Leg Workout',
    duration: '15',
    level: 'Intermediate',
    icon: Icons.directions_run,
    steps: [
      'Warm-up (5 minutes)',
      'Squats (3 sets x 12 reps)',
      'Lunges (3 sets x 10 reps per leg)',
      'Calf Raises (3 sets x 20 reps)',
      'Cool-down (5 minutes)',
    ],
  ),
  Workout(
    name: 'Upper Body Workout',
    duration: '20',
    level: 'Intermediate',
    icon: Icons.accessibility,
    steps: [
      'Warm-up (5 minutes)',
      'Push-ups (3 sets x 10 reps)',
      'Shoulder Press (3 sets x 12 reps)',
      'Bicep Curls (3 sets x 15 reps)',
      'Tricep Dips (3 sets x 12 reps)',
      'Cool-down (5 minutes)',
    ],
  ),
  Workout(
    name: 'Cardio Blast',
    duration: '25',
    level: 'Advanced',
    icon: Icons.directions_bike,
    steps: [
      'Warm-up (5 minutes)',
      'Jumping Jacks (3 sets x 1 minute)',
      'Burpees (3 sets x 10 reps)',
      'Mountain Climbers (3 sets x 30 seconds)',
      'High Knees (3 sets x 1 minute)',
      'Cool-down (5 minutes)',
    ],
  ),
  Workout(
    name: 'Yoga Flow',
    duration: '30',
    level: 'Beginner',
    icon: Icons.self_improvement,
    steps: [
      'Warm-up (5 minutes)',
      'Sun Salutation (5 rounds)',
      'Warrior Pose (3 sets x 30 seconds per side)',
      'Tree Pose (3 sets x 30 seconds per side)',
      'Child\'s Pose (3 sets x 1 minute)',
      'Cool-down (5 minutes)',
    ],
  ),
  Workout(
    name: 'Full Body Strength',
    duration: '35',
    level: 'Advanced',
    icon: Icons.sports_gymnastics,
    steps: [
      'Warm-up (5 minutes)',
      'Deadlifts (3 sets x 8 reps)',
      'Bench Press (3 sets x 10 reps)',
      'Pull-ups (3 sets x 6 reps)',
      'Squats (3 sets x 10 reps)',
      'Plank (3 sets x 45 seconds)',
      'Cool-down (5 minutes)',
    ],
  ),
];

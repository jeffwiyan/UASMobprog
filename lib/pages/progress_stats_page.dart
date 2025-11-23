import 'package:flutter/material.dart';
import 'package:health_fitness_app/utils/constants.dart';
import 'package:health_fitness_app/utils/storage_helper.dart';

class ProgressStatsPage extends StatefulWidget {
  const ProgressStatsPage({super.key});

  @override
  State<ProgressStatsPage> createState() => _ProgressStatsPageState();
}

class _ProgressStatsPageState extends State<ProgressStatsPage> {
  Map<String, int> progress = {'steps': 0, 'calories': 0, 'workouts': 0};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final data = await StorageHelper.getWeeklyProgress();
    setState(() {
      progress = data;
    });
  }

  Widget _buildProgressCard(String title, int current, int goal, IconData icon) {
    double progressValue = (current / goal).clamp(0.0, 1.0);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppConstants.primaryColor, size: 30),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppConstants.titleStyle,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              '$current / $goal',
              style: AppConstants.bodyStyle,
            ),
            Text(
              '${(progressValue * 100).toInt()}% Complete',
              style: TextStyle(
                color: progressValue >= 1.0 ? AppConstants.successColor : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weekly Goals Progress")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your weekly fitness goals',
              style: AppConstants.headlineStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            _buildProgressCard(
              'Steps',
              progress['steps']!,
              AppConstants.defaultStepsGoal,
              Icons.directions_walk,
            ),
            _buildProgressCard(
              'Calories Burned',
              progress['calories']!,
              AppConstants.defaultCaloriesGoal,
              Icons.local_fire_department,
            ),
            _buildProgressCard(
              'Workouts Completed',
              progress['workouts']!,
              7, // Weekly goal: 7 workouts
              Icons.fitness_center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Simulate updating progress (in real app, this would come from activity tracking)
                      final newSteps = progress['steps']! + 1000;
                      final newCalories = progress['calories']! + 50;
                      final newWorkouts = progress['workouts']! + 1;
                      await StorageHelper.saveWeeklyProgress(
                        steps: newSteps,
                        calories: newCalories,
                        workouts: newWorkouts,
                      );
                      await _loadProgress();
                    },
                    child: const Text('Simulate Progress'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await StorageHelper.saveWeeklyProgress(
                        steps: 0,
                        calories: 0,
                        workouts: 0,
                      );
                      await _loadProgress();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Reset All'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

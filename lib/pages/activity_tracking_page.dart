import 'package:flutter/material.dart';
import 'package:health_fitness_app/utils/constants.dart';
import 'package:health_fitness_app/utils/storage_helper.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class ActivityTrackingPage extends StatefulWidget {
  const ActivityTrackingPage({super.key});

  @override
  State<ActivityTrackingPage> createState() => _ActivityTrackingPageState();
}

class _ActivityTrackingPageState extends State<ActivityTrackingPage> {
  Map<String, int> progress = {'steps': 0, 'calories': 0, 'workouts': 0};
  int pushUps = 0;
  int sitUps = 0;
  int squats = 0;
  int planks = 0;

  // Pedometer variables
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  String _steps = '0';
  int _initialSteps = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _initPedometer();
  }

  void _initPedometer() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(_onPedestrianStatusChanged)
        .onError(_onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream
        .listen(_onStepCount)
        .onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    if (!_isInitialized) {
      _initialSteps = event.steps;
      _isInitialized = true;
    }

    int currentSteps = event.steps - _initialSteps;
    setState(() {
      _steps = currentSteps.toString();
    });

    // Auto-save steps to progress
    _saveStepsAutomatically(currentSteps);
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void _onStepCountError(error) {
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void _onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  Future<void> _saveStepsAutomatically(int steps) async {
    await StorageHelper.saveWeeklyProgress(
      steps: steps,
      calories: progress['calories']!,
      workouts: progress['workouts']!,
    );
  }

  Future<void> _loadProgress() async {
    final data = await StorageHelper.getWeeklyProgress();
    setState(() {
      progress = data;
    });
  }

  void increment(String type) {
    setState(() {
      if (type == 'pushup') pushUps++;
      if (type == 'situp') sitUps++;
      if (type == 'squat') squats++;
      if (type == 'plank') planks++;
    });
  }

  void decrement(String type) {
    setState(() {
      if (type == 'pushup' && pushUps > 0) pushUps--;
      if (type == 'situp' && sitUps > 0) sitUps--;
      if (type == 'squat' && squats > 0) squats--;
      if (type == 'plank' && planks > 0) planks--;
    });
  }

  Future<void> _saveActivity() async {
    final totalReps = pushUps + sitUps + squats + planks;
    final caloriesBurned = totalReps * 5; // Rough estimate: 5 calories per rep
    final newCalories = progress['calories']! + caloriesBurned;

    await StorageHelper.saveWeeklyProgress(
      steps: progress['steps']!,
      calories: newCalories,
      workouts: progress['workouts']!,
    );

    await _loadProgress();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Activity saved! +$caloriesBurned calories burned'),
          backgroundColor: AppConstants.successColor,
        ),
      );
    }

    // Reset counters
    setState(() {
      pushUps = 0;
      sitUps = 0;
      squats = 0;
      planks = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Tracking'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today\'s Activity',
                style: AppConstants.headlineStyle,
              ),
              const SizedBox(height: 16),
              _buildActivityRing(context),
              const SizedBox(height: 24),
              // Automatic Step Counter
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_walk, color: AppConstants.primaryColor, size: 30),
                          const SizedBox(width: 12),
                          Text(
                            'Steps Today',
                            style: AppConstants.titleStyle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _steps,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Activity History',
                style: AppConstants.titleStyle,
              ),
              const SizedBox(height: 16),
              _buildActivityHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityRing(BuildContext context) {
    final totalCalories = progress['calories']!;
    final progressValue = (totalCalories / AppConstants.defaultCaloriesGoal).clamp(0.0, 1.0);

    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                Center(
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
                  ),
                ),
                Center(
                  child: Text(
                    '${(progressValue * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$totalCalories cal burned',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  void _showActivityDetail(Map<String, String> activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${activity['date']} Activity Details',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Steps Taken', '${activity['steps']} steps', Icons.directions_walk),
                          const SizedBox(height: 12),
                          _buildDetailRow('Calories Burned', '${activity['calories']} calories', Icons.local_fire_department),
                          const SizedBox(height: 12),
                          _buildDetailRow('Workouts Completed', '${activity['workouts']} workouts', Icons.fitness_center),
                          const SizedBox(height: 12),
                          _buildDetailRow('Active Time', activity['duration']!, Icons.access_time),
                          const SizedBox(height: 16),
                          const Text(
                            'Workout Breakdown:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildWorkoutBreakdown(activity),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppConstants.primaryColor, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkoutBreakdown(Map<String, String> activity) {
    // Dummy workout breakdown data
    final workouts = [
      {'name': 'Push Ups', 'sets': '3', 'reps': '15'},
      {'name': 'Sit Ups', 'sets': '3', 'reps': '20'},
      {'name': 'Squats', 'sets': '4', 'reps': '12'},
      {'name': 'Plank', 'sets': '3', 'reps': '45s'},
    ];

    return Column(
      children: workouts.map((workout) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                workout['name']!,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                '${workout['sets']} × ${workout['reps']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActivityHistory() {
    // Dummy activity history data
    final activities = [
      {
        'date': 'Today',
        'steps': _steps,
        'calories': progress['calories'].toString(),
        'workouts': progress['workouts'].toString(),
        'duration': '2h 30m',
      },
      {
        'date': 'Yesterday',
        'steps': '8,542',
        'calories': '320',
        'workouts': '3',
        'duration': '1h 45m',
      },
      {
        'date': '2 days ago',
        'steps': '7,231',
        'calories': '280',
        'workouts': '2',
        'duration': '1h 20m',
      },
      {
        'date': '3 days ago',
        'steps': '9,156',
        'calories': '380',
        'workouts': '4',
        'duration': '2h 15m',
      },
      {
        'date': '4 days ago',
        'steps': '6,789',
        'calories': '250',
        'workouts': '2',
        'duration': '1h 10m',
      },
      {
        'date': '5 days ago',
        'steps': '8,934',
        'calories': '350',
        'workouts': '3',
        'duration': '2h 5m',
      },
      {
        'date': '6 days ago',
        'steps': '7,654',
        'calories': '290',
        'workouts': '3',
        'duration': '1h 35m',
      },
    ];

    return Column(
      children: activities.map((activity) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            onTap: () => _showActivityDetail(activity),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      activity['date']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          '${activity['steps']} steps',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          '${activity['calories']} cal',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          '${activity['workouts']} workouts',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          activity['duration']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

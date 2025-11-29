import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _pageTransitionDuration = 300;

  List<Widget> _buildPages() {
    return [
      _buildPage(
        icon: Icons.fitness_center,
        title: 'Track Your Workouts',
        description: 'Log every workout session and monitor your progress over time.',
      ),
      _buildPage(
        icon: Icons.track_changes,
        title: 'Monitor Your Activity',
        description: 'Stay motivated by tracking your steps, distance, and calories burned daily.',
      ),
      _buildPage(
        icon: Icons.bar_chart,
        title: 'View Your Statistics',
        description: 'Gain insights into your fitness habits with detailed charts and statistics.',
      ),
    ];
  }

  Widget _buildPage({required IconData icon, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: Theme.of(context).primaryColor),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int pageCount) {
    return Row(
      children: List.generate(pageCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_currentPage == _buildPages().length - 1) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('hasOnboarded', true);
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: _pageTransitionDuration),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Text(_currentPage == _buildPages().length - 1 ? 'Start' : 'Next'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _buildPages(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPageIndicator(_buildPages().length),
                _buildActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

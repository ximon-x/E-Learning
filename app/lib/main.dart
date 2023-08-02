import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Learning App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              'assets/app_logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Learn Anytime, Anywhere',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Discover a world of knowledge with our e-learning app!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Add navigation logic to your e-learning app's home screen
              },
              child: const Text('Get Started'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Add navigation logic to a page that explains the app's features or benefits in more detail
              },
              child: const Text('Learn More'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Already have an account?',
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                // Add navigation logic to the login page
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

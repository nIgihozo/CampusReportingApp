import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding (
        padding: const EdgeInsets.all(24.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container (
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.campaign_rounded, size: 60, color: Colors.deepPurple),
        ),
        const SizedBox(height: 30),
        const Text(
          "Campus Report and Track Issue Application",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 15),
        const Text(
          "Welcome to the Campus Report and Track Issue Application! This app is designed to help you report and track issues on campus easily and efficiently. Whether it's a maintenance problem, safety concern, or any other issue, you can use this app to submit your report and stay updated on its progress.",
          style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 35),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),

              onPressed: () => Navigator.pushReplacement (
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
              child: const Text("Get Started", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        ],
        ),
      ),
    );
  }
}
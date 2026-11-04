import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  // Role-Specific Base Controller Fields
  final _studentIdController = TextEditingController();
  final _studentYearController = TextEditingController();
  final _studentProgrameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _adminCodeController = TextEditingController();

  String _selectRole = 'Student'; // Default selected role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CREATE ACCOUNT"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Role Sector Based
            DropdownButtonFormField<String>(
              initialValue: _selectRole,
              items: ['Student', 'Faculty', 'Admin']
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value)  => setState(() => _selectRole = value!),
              decoration: const InputDecoration(labelText: 'Select Role'),
            ),
            const SizedBox(height: 12),

            // Common Fields for All Roles
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Names'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 12),

            
            // Role-based Specification
            if(_selectRole == 'Student') ...[
              TextField(
                controller: _studentIdController,
                decoration: const InputDecoration(labelText: 'Student ID'),
              ),
              TextField(
                controller: _studentYearController,
                decoration: const InputDecoration(labelText: 'Student Year'),
              ),
              TextField(
                controller: _studentProgrameController,
                decoration: const InputDecoration(labelText: 'Student Program'),
              ),
            ] else if (_selectRole == 'Faculty') ...[
              TextField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
              ),
            ] else if (_selectRole == 'Admin') ...[
              TextField(
                controller: _adminCodeController,
                decoration: const InputDecoration(labelText: 'Admin Access Code'),
                obscureText: true,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Signup logic
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text('Create Account'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Have account already? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _extraCtrl = TextEditingController();
  String _role = 'Student';
  bool _isLoading = false;
  final _authService = AuthService();

  //  Administrative account registration
  static const String _secretAdminCode = 'ADMIN123';

  void _handleSignUp() async {
    // 1. Frontend Empty Field Validation
    if (_nameCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        _passCtrl.text.trim().isEmpty ||
        _extraCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    // 2. Email Formatting Validation
    if (!_emailCtrl.text.trim().contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // 3. Password Length Validation
    if (_passCtrl.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters long.')),
      );
      return;
    }

    // 4. Admin Access Code Validation
    if (_role == 'Admin' && _extraCtrl.text.trim() != _secretAdminCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Admin Access Code.')),
      );
      return;
    }

    // 5. Proceed with Firebase Signup if all local validations pass
    setState(() => _isLoading = true);
    String? err = await _authService.signUp(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      role: _role,
      extraDetail: _extraCtrl.text.trim(),
    );
    setState(() => _isLoading = false);

    if (!mounted) return;
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

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
            DropdownButtonFormField<String>(
              initialValue: _role,
              items: ['Student', 'Faculty', 'Admin']
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (val) => setState(() {
                _role = val!;
                _extraCtrl.clear(); // Clear extra field when switching roles
              }),
              decoration: const InputDecoration(labelText: 'Select Role'),
            ),
            const SizedBox(height: 16),
            if (_role == 'Student') ...[
              TextField(
                controller: _extraCtrl,
                decoration: const InputDecoration(labelText: 'Student ID'),
              ),
            ] else if (_role == 'Faculty') ...[
              TextField(
                controller: _extraCtrl,
                decoration: const InputDecoration(labelText: 'Department Name'),
              ),
            ] else if (_role == 'Admin') ...[
              TextField(
                controller: _extraCtrl,
                decoration: const InputDecoration(labelText: 'Admin Access Code'),
                obscureText: true,
              ),
            ],
            const SizedBox(height: 24),
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Names'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'ALU Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _handleSignUp,
                    child: const Text('Sign Up'),
                  ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
              child: const Text('Have account already? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
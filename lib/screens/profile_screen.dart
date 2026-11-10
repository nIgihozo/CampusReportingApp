import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  // Edit Name Dialog
  void _editNameDialog() {
    final nameController = TextEditingController(text: user?.displayName ?? '');
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profile Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Enter your full name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext), 
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)),
            onPressed: () async {
              try {
                await user?.updateDisplayName(nameController.text.trim());
                await user?.reload();
                
                if (!mounted) return;
                setState(() {});
                
                Navigator.pop(dialogContext); // Closing dialog safely
                
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Name updated successfully!')),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Change Password Action
  Future<void> _changePassword() async {
    try {
      if (user?.email != null) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent! Check your inbox.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Support Dialog
  void _showSupportDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Campus Support'),
        content: const Text('For technical issues or emergency campus reporting support, please contact the IT Administration office at support@alu.edu.rw or call ext. 404.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayName = user?.displayName ?? user?.email?.split('@').first ?? 'Student';
    String displayEmail = user?.email ?? 'student@alustudent.com';

    String roleBased = 'Student';
    if(displayEmail.toLowerCase().endsWith('@alueducation.com')) {
      roleBased= 'Staff';
    } else if (displayEmail.toLowerCase().endsWith('@alustudent.com')) {
      roleBased = 'Student';
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(displayName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18, color: Color(0xFF7C3AED)),
                  onPressed: _editNameDialog,
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(displayEmail, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
              child: Text(roleBased, style: const TextStyle(color: Color(0xFF7C3AED), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(height: 24),
            
            // Settings & Interactive Options
            _buildActionTile(Icons.school, 'Department', 'BSE', onTap: () {}),
            _buildActionTile(Icons.location_on, 'Campus Location', 'Kigali, Rwanda', onTap: () {}),
            _buildActionTile(Icons.lock_outline, 'Change Password', 'Update via email', onTap: _changePassword),
            _buildActionTile(Icons.support_agent, 'Help & Support', 'Contact Support Team', onTap: _showSupportDialog),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String value, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF7C3AED), size: 20),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            const Spacer(),
            Text(value, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
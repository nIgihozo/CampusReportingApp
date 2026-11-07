import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'report_screen.dart';
import 'reports_screen.dart';
import 'incident_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('incidents')
              .where('userId', isEqualTo: currentUser?.uid ?? 'anonymous')
              .snapshots(),
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs ?? [];
            
            // Dynamic backend metrics calculation
            int total = docs.length;
            int inProgress = docs.where((d) => d['status'] == 'In Progress').length;
            int resolved = docs.where((d) => d['status'] == 'Resolved').length;
            int submitted = docs.where((d) => d['status'] == 'Submitted').length;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello, Igihozo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text('Help make our campus safer', style: TextStyle(fontSize: 16, color: Colors.black)),
                          Text('Report issues and track their resolution', style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      IconButton(
                        icon: const Badge(label: Text('1'), child: Icon(Icons.notifications)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Banner Card
                  Container(
                    height: 205,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF9333EA)]),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('asset/campus.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('See an issue\non campus?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        const Text('Report it and help improve our learning environment.', style: TextStyle(fontSize: 12, color: Colors.white70)),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportIncidentScreen())),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(backgroundColor: Color(0xFF7C3AED), radius: 10, child: Icon(Icons.add, color: Colors.white, size: 16)),
                                    SizedBox(width: 10),
                                    Text('Report an Issue', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7C3AED))),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF7C3AED)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Report Summary Section (Backend Data)
                  const Text('Report Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SummaryCard(count: '$total', label: 'My Reports', icon: Icons.description, color: Colors.purple),
                      _SummaryCard(count: '$inProgress', label: 'In Progress', icon: Icons.access_time, color: Colors.blue),
                      _SummaryCard(count: '$resolved', label: 'Resolved', icon: Icons.check_circle, color: Colors.green),
                      _SummaryCard(count: '$submitted', label: 'Submitted', icon: Icons.error, color: Colors.red),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Recent Reports Section (Backend Stream)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Recent Reports', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())),
                        child: const Text('See all', style: TextStyle(color: Color(0xFF7C3AED))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  docs.isEmpty
                      ? const Text('No recent reports found.', style: TextStyle(color: Colors.grey))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: docs.length > 3 ? 3 : docs.length, // Show up to 3 recent items
                          itemBuilder: (context, index) {
                            var doc = docs[index];
                            var data = doc.data() as Map<String, dynamic>;
                            var status = data['status'] ?? 'Submitted';
                            Color statusColor = status == 'Resolved' ? Colors.green : status == 'In Progress' ? Colors.blue : Colors.amber;

                            return GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => IncidentDetailsScreen(report: doc))),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50, height: 50,
                                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                                      child: (data['imageBase64'] ?? '').isNotEmpty
                                          ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(base64Decode(data['imageBase64']), fit: BoxFit.cover))
                                          : const Icon(Icons.image, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(data['title'] ?? 'Untitled', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          const SizedBox(height: 2),
                                          Text(data['location'] ?? '', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                                      child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen()));
          if (index == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportIncidentScreen()));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 36, color: Color(0xFF7C3AED)), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final Color color;
  const _SummaryCard({required this.count, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}